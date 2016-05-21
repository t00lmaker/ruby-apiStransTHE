# Ruby Strans Client - 1.0.0

Essa lib é um cliente para a [Api Inthegra](https://inthegra.strans.teresina.pi.gov.br/) da [Strans Teresina](http://strans.teresina.pi.gov.br/).

Suporta Ruby 2.0 ou mais novo.

## Installation

```
# gem install strans-client
```
ou no seu GEMFILE utilize:

```
gem 'strans-client', '1.0.0'
```

## Utilização

1. Intancie um objeto StransClient passando as credenciais de acesso a api que podem ser adiqueridas na [página da API](https://inthegra.strans.teresina.pi.gov.br/apikey).  É necessário se cadastrar e solicitar uma key para uma aplicação.

```
require 'strans-client'

cliente = StransClient.new('oseu@email.com', 'suaSenha', 'suaChaveAqui')
```

2. Agora você pode realizar as chamadas da API que estão documentadas [aqui](https://inthegra.strans.teresina.pi.gov.br/docs)

```
# Autentica na na API, usando as credenciais
# do construtor acima.
cliente.get(<path>, <SePrecisarDeParametro>)
```
#Possíveis paths:

```
:linhas => '/linhas',
:veiculos => '/veiculos',
:veiculos_linha => '/veiculosLinha',
:paradas => '/paradas',
:paradas_linha => '/paradasLinha',
```
#Exemplos:

```
  # Todas as linhas disponiveis.
  cliente.get(:linhas)

  # GET /paradas?busca=ininga
  # Todas as linhas que possuam o termo “ininga”.
  cliente.get(:linhas, 'ininga')

  # GET /paradasLinha?busca=0402
  # Retorna todas as paradas da linha indicada com o código indicado.
  cliente.get(:paradas_linha, '0402')

```

#Modelo

Todas as chamadas retorna objetos populados, em que você pode usar o metodo
to_json para transforma-los em JSON. Esse modelo possui os mesmo atributos
do JSON retornado pela api, mas com os nomes dos atributos em minúsculos.
Veja o modelo no código acima.

#Erros

Alguns erros podem ocorrer por conta de problemas na API ou na requisição.
Todos eles retorna uma instância da classe Erro, com uma mensagem associada.

## Próximos passos

 - Transformar em uma gem - OK  
 - Criação de um modelo Ruby - OK
 - Gerenciar  erros retornados pela API. (+/-)
 - Gerenciar automaticamente o token de autenticação. - OK
 - Molhar o método to_json dos modelos, tá funcional, mas feio.
 - Criar um cliente lazy que carrega informações em um cache.
