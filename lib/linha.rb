require 'json'
require_relative 'veiculo'
require 'byebug'

class LinhaStrans

  attr_accessor :codigoLinha, :denominacao, :origem,
                :retorno, :circular, :veiculos, :paradas

  def initialize(fields)
    @codigoLinha = fields['CodigoLinha'] || fields[:codigoLinha] 
    @denominacao  = fields['Denomicao'] || fields[:denomicao]
    @origem       = fields['Origem']  || fields[:origem]
    @retorno      = fields['Retorno'] || fields[:retorno]
    @circular     = fields['Circular'] || fields[:circular]
    @veiculos = load_objs(fields['Veiculos'], VeiculoStrans)
    @paradas  = load_objs(fields['Paradas'], ParadaStrans)
  end

  def load_objs(objs, k)
    if objs.is_a?(Array)
      map = objs.map do |o|
        o = k.new(o)
        o.linha = self
        o
      end
    end
    map
  end

  def to_json(*a)
    serialized = {}
    serialized[:codigoLinha] = @codigo if @codigo
    serialized[:denominacao] = @denominacao if @denominacao
    serialized[:origem] = @origem if @denominacao
    serialized[:retorno] = @retorno if @retorno
    serialized[:Circular] = @circular if @circular
    serialized[:veiculos] = @veiculos if @veiculos
    serialized[:paradas] = @paradas if @paradas
    serialized.to_json *a
  end
end
