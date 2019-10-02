#!/usr/bin/env ruby

require 'irb'
require_relative '../lib/strans-client'

# Entre no projeto e execute '$ bin/console.rb', que abrirar 
# o irb, então poderá instanciar um client e interagir com a lib. Exemplo: 

# irb> cliente = StransClient.new('oseu@email.com', 'suaSenha', 'suaChaveAqui'
# irb> linhas = cliente.get(:linhas)
# irb> puts linhas

IRB.start

