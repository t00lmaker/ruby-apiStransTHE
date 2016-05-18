
class Linha

  def initialize(fields)
    load_atts(fields)
  end

  attr_accessor :codigoLinha, :denomicao, :origem,
                :retorno, :circular, :veiculos, :paradas

  def load_atts(fields)
    @codigoLinha  = fields['CodigoLinha'] || fields[:codigoLinha]
    @denomicao    = fields['Denomicao'] || fields[:denomicao]
    @origem       = fields['Origem']  || fields[:origem]
    @retorno      = fields['Retorno'] || fields[:retorno]
    @circular     = fields['Circular'] || fields[:circular]
    @veiculos = load_objs(fields['Veiculos']||fields[:veiculos], Veiculo)
    @paradas  = load_objs(fields['Paradas']||fields[:paradas], Parada)
  end


  def load_objs(objs, klass)
    if objs.is_a?(Array)
      objs = objs.map do |o|
          o = klass.new(o)
          o.linha = self
          o
      end
    end
    return objs
  end

end
