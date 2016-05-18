
class Linha

  def initialize(fields)
    load_atts(fields)
  end

  attr_accessor :codigoLinha, :denomicao, :origem, :retorno, :circular, :veiculos

  def load_atts(fields)
    @codigoLinha  = fields['CodigoLinha'] || fields[:codigoLinha]
    @denomicao    = fields['Denomicao'] || fields[:denomicao]
    @origem       = fields['Origem']  || fields[:origem]
    @retorno      = fields['Retorno'] || fields[:retorno]
    @circular     = fields['Circular'] || fields[:circular]
    load_veiculos(fields['Veiculos'])
  end

  def load_veiculos(veiculos)
    if veiculos.is_a?(Array)
      veiculos = veiculos.map do |v|
          v = Veiculo.new(v)
          v.linha = self
          v
      end
    end
    @veiculos = veiculos
  end

end
