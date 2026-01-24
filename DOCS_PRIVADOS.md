# Comandos para Disparo Manual de Releases

Certifique-se de ter a CLI `gh` instalada e autenticada (`gh auth login`).

## 1. Criar e Subir a Tag (Pré-requisito)

O build precisa de uma tag para associar aos arquivos.

```bash
git tag v1.0.0
git push origin v1.0.0
```

## 2. Disparar os Workflows via Terminal

Use os comandos abaixo substituindo `v1.0.0` pela tag desejada.

### Linux
```bash
gh workflow run build_linux.yml --ref v1.0.0
```

### Mac
```bash
gh workflow run build_mac.yml --ref v1.0.0
```

### Windows
```bash
gh workflow run build_windows.yml --ref v1.0.0
```

## 3. Acompanhar Execução

Para ver o status dos builds no terminal:

```bash
gh run list
```

Ou para acompanhar um específico (selecione interativamente):

```bash
gh run watch
```
