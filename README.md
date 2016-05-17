# Ruby Strans Client

[![Stories in Ready](http://badge.waffle.io/jeremytregunna/ruby-trello.png)](http://waffle.io/jeremytregunna/ruby-trello)
[![Build Status](https://secure.travis-ci.org/jeremytregunna/ruby-trello.png)](http://travis-ci.org/jeremytregunna/ruby-trello) [![Dependency Status](https://gemnasium.com/jeremytregunna/ruby-trello.png)](https://gemnasium.com/jeremytregunna/ruby-trello.png)
[![Code Climate](https://codeclimate.com/github/jeremytregunna/ruby-trello/badges/gpa.svg)](https://codeclimate.com/github/jeremytregunna/ruby-trello)

Essa lib é um cliente para a [Api Inthegra](https://inthegra.strans.teresina.pi.gov.br/) da [Strans Teresina](http://strans.teresina.pi.gov.br/).

Suporta Ruby 2.0 ou mais novo.

## Installation

```
# gem install strans-client
```
ou no seu GEMFILE utilize:

```
gem 'strans-client', '~> 0.0.1'
```

## Utilização

1. Intancie um objeto StransClient passando as credenciais de acesso a api que podem ser adiqueridas na [página da API](https://inthegra.strans.teresina.pi.gov.br/apikey).  É necessário se cadastrar e solicitar uma key para uma aplicação.

```
require 'strans-client'

cliente = BasicClinet.new('oseu@email.com', 'suaSenha', 'suaChaveAqui')
```

2. Agora você pode realizar as chamadas da API que estão documentadas [aqui](https://inthegra.strans.teresina.pi.gov.br/docs)

```
# Retorna todas as linhas de ônibus de Teresina.
cliente.linhas()

# Retorna todas as linhas que possua a palavra ininga.
cliente.linhas('ininga')

```
Ps. : Provisoriamente o cliente retorna um JSON.


## Próximos passos

 - Criação de um modelo ruby.
 - Gerencia automatica do token de autenticação.
 - Cache de informações.
