class Parada
  attr_accessor :codigoParada, :denomicao, :endereco, :lat, :long, :linha

  def initialize(fields)
    @codigoParada   = fields['CodigoParada'] || fields[:codigoParada]
    @denomicao      = fields['Denomicao'] || fields[:denomicao]
    @endereco       = fields['Endereco'] || fields[:endereco]
    @lat            = fields['Lat']  || fields[:lat]
    @long           = fields['Long'] || fields[:long]
    @linha          = fields[:linha]
  end
end
