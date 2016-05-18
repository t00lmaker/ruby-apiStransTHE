class Parada

  def initialize(fields)
    load_atts(fields)
  end

  attr_accessor :codigoParada, :denomicao, :endereco, :lat, :long, :linha

  def load_atts(fields)
    @codigoParada   = fields['CodigoParada'] || fields[:codigoParada]
    @denomicao      = fields['Denomicao'] || fields[:denomicao]
    @endereco       = fields['Endereco'] || fields[:endereco]
    @lat            = fields['Lat']  || fields[:lat]
    @long           = fields['Long'] || fields[:long]
  end

end
