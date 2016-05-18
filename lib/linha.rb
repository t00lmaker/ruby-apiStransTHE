
class Linha

  def initialize(fields)
    load_atts(fields)
  end

  attr_accessor :codigoLinha, :denomicao, :origem, :retorno, :circular

  def load_atts(fields)
    @codigoLinha  = fields['CodigoLinha'] || fields[:codigoLinha]
    @denomicao    = fields['Denomicao'] || fields[:denomicao]
    @origem       = fields['Origem']  || fields[:origem]
    @retorno      = fields['Retorno'] || fields[:retorno]
    @circular     = fields['Circular'] || fields[:circular]
  end

end
