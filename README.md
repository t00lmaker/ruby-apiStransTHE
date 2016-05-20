# Ruby Strans Client

Essa lib é um cliente para a [Api Inthegra](https://inthegra.strans.teresina.pi.gov.br/) da [Strans Teresina](http://strans.teresina.pi.gov.br/).

Suporta Ruby 2.0 ou mais novo.

## Instalação

```
# gem install strans-client
```

ou no seu `Gemfile` utilize:

```
gem 'strans-client', '~> 0.0.2'
```

## Utilização

1. Intancie um objeto StransClient passando as credenciais de acesso a api que podem ser adiqueridas na [página da API](https://inthegra.strans.teresina.pi.gov.br/apikey). É necessário se cadastrar e solicitar uma key para uma aplicação.

```
require 'strans-client'

cliente = StransClient.new('oseu@email.com', 'suaSenha', 'suaChaveAqui')
```

2. Agora você pode realizar as chamadas da API que estão documentadas [na página de documentação da própria API](https://inthegra.strans.teresina.pi.gov.br/docs).

```
# Autentica na na API, usando as credenciais 
# do construtor acima. 
cliente.autentic()

# Retorna todas as linhas de ônibus de Teresina.
cliente.linhas()

# Retorna todas as linhas que possua a palavra ininga.
cliente.linhas('ininga')

# ... Todos os demais metodos da API.
```

Atenção: O token de autenticação da API tem validade de 10 minutos, por enquanto você deve gerenciar isso. 
Na próxima atualização da gem isso pode ser gerenciado pela mesma.   

## Próximos passos

 - Transformar em uma gem - OK  
 - Criação de um modelo ruby - OK
 - Gerencia automática do token de autenticação.
 - Criar um cliente lazy que carrega informações em um cache.
