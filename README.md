# Salop Releases

Este repositório é dedicado à orquestração de builds e distribuição de releases do projeto **Bereia Verse** (Salop).

## Estrutura

Os workflows do GitHub Actions aqui configurados:
1.  Clonam o repositório privado do código-fonte.
2.  Compilam os binários para Linux (.deb), Windows (.msi) e macOS (.dmg).
3.  Publicam os artefatos na aba [Releases](https://github.com/HelenoSalgado/salop-releases/releases).

## Builds

Os builds são disparados manualmente para garantir controle sobre as versões publicadas.
