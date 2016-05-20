class Linha
  attr_accessor :codigoLinha, :denomicao, :origem, :retorno, :circular,
    :veiculos, :paradas

  def initialize(fields = {})
    @codigoLinha  = fields['CodigoLinha'] || fields[:codigoLinha]
    @denomicao    = fields['Denomicao'] || fields[:denomicao]
    @origem       = fields['Origem']  || fields[:origem]
    @retorno      = fields['Retorno'] || fields[:retorno]
    @circular     = fields['Circular'] || fields[:circular]
    @veiculos     = load_objects(fields['Veiculos'] || fields[:veiculos], Veiculo)
    @paradas      = load_objects(fields['Paradas'] || fields[:paradas], Parada)
  end

  private

  def load_objects(objects, klass)
    if objects.is_a?(Array)
      objects.map do |attributes|
        klass.new(attributes.merge(linha: self))
      end
    end
  end
end
