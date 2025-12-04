# Códigos de Concreto Estrutural I (nFOC)

Este repositório contém códigos em MATLAB desenvolvidos para resolver problemas de Concreto Estrutural I, envolvendo análise de seções em nFOC, conforme a disciplina EDI-38 do ITA.

## Como usar?
- Ler o documento Instruções.pdf, ele é a explicação mais prática e completa do uso dos códigos
### Instruções gerais:
1. Crie scripts para executar as funções
2. Altere os parâmetros da seção no início do script
3. Atenção com códigos que não são funções: geradores de diagramas e plotagem de seções transversais com a linha neutra

## Quais códigos usar para cada tipo de problema?

### nFOC
1. Cálculo de esforços resultantes - esforcos.m
2. Verificação de seções transversais - verificacao_nFOC.m
3. Dimensionamento de seções transversais - dimensionamento_nFOC.m

### ELUi
4. Verificação de estabilidade de pilares - verificapilar.m
5. Trajetória de equilíbrio - plota_teq.m (muito lento)
6. Compressão uniforme - compressao_uniforme.m
7. Pilar padrão - pilar_padrao.m

Os demais códigos são scripts que chamam as funções ou funções auxiliares (detalhadas adequadamente no pdf) para as funções principais.

## Linguagens e Ferramentas
- MATLAB

## Autor
Antônio Garcia
