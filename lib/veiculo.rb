class Veiculo

  def initialize(fields)
    load_atts(fields)
  end

  attr_accessor :codigoVeiculo, :hora, :lat, :long

  def load_atts(fields)
    @codigoVeiculo  = fields['CodigoVeiculo'] || fields[:codigoVeiculo]
    @hora           = fields['Hora'] || fields[:hora]
    @lat            = fields['Lat']  || fields[:lat]
    @long           = fields['Long'] || fields[:long]
  end

end
