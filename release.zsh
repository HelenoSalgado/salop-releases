#!/usr/bin/env zsh

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

TAG=$1

if [[ -z "$TAG" ]]; then
  echo -e "${RED}Erro: Nenhuma tag fornecida.${NC}"
  echo -e "Uso: ${YELLOW}./release.zsh <tag>${NC}"
  echo -e "Exemplo: ./release.zsh v1.0.2"
  exit 1
fi

echo -e "${BLUE}=== Iniciando Processo de Release: ${TAG} ===${NC}"

# 1. Verificar/Criar Tag
if git rev-parse "$TAG" >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Tag $TAG já existe localmente.${NC}"
else
    echo -e "${YELLOW}Tag $TAG não encontrada.${NC}"
    echo -n "Deseja criar e enviar a tag $TAG agora? (S/n) "
    read RESPONSE
    if [[ "$RESPONSE" =~ ^([sS][iI]|[sS]|[yY])$ ]] || [[ -z "$RESPONSE" ]]; then
        git tag "$TAG"
        git push origin "$TAG"
        echo -e "${GREEN}✓ Tag $TAG criada e enviada.${NC}"
    else
        echo -e "${RED}Operação cancelada.${NC}"
        exit 1
    fi
fi

# 2. Disparar Workflows
echo -e "\n${BLUE}=== Disparando Workflows no GitHub ===${NC}"

WORKFLOWS=("build_linux.yml" "build_mac.yml" "build_windows.yml")

for WF in "${WORKFLOWS[@]}"; do
    echo -n "Disparando $WF... "
    gh workflow run "$WF" --ref "$TAG"
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}OK${NC}"
    else
        echo -e "${RED}Falha${NC}"
    fi
done

# 3. Monitoramento
echo -e "\n${BLUE}=== Status dos Builds ===${NC}"
echo "Use 'gh run watch' para acompanhar interativamente ou aguarde a tabela abaixo:"
sleep 2
gh run list --limit 3
