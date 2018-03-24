require 'json'
require_relative 'veiculo'

class Linha

  attr_accessor :codigoLinha, :denominacao, :origem,
                :retorno, :circular, :veiculos, :paradas

  def initialize(fields)
    if(fields)
      @codigoLinha  = fields['CodigoLinha'] || fields[:codigoLinha]
      @denominacao  = fields['Denomicao'] || fields[:denomicao]
      @origem       = fields['Origem']  || fields[:origem]
      @retorno      = fields['Retorno'] || fields[:retorno]
      @circular     = fields['Circular'] || fields[:circular]
      @veiculos = load_objs(fields['Veiculos'], Veiculo)
      @paradas  = load_objs(fields['Paradas'], Parada)
    end
  end

  def load_objs(objs, k)
    if objs.is_a?(Array)
      map = objs.map do |o|
        o = k.new(o)
        o.linha = self
        o
      end
    end
    return map
  end

  def to_json(*a)
    serialized = Hash.new
    serialized[:codigoLinha] = @codigoLinha if(@codigoLinha)
    serialized[:denominacao] = @denominacao if(@denominacao)
    serialized[:origem] = @origem if(@denominacao)
    serialized[:retorno] = @retorno if(@retorno)
    serialized[:Circular] = @circular if(@circular)
    serialized[:veiculos] = @veiculos if(@veiculos)
    serialized[:paradas] = @paradas if(@paradas)
    serialized.to_json(*a)
  end
end
