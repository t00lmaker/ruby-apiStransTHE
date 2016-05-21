require 'require_models'

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

  def to_json(*a)
      serialized = Hash.new
      serialized[:codigoParada] = @codigoParada if(@codigoParada)
      serialized[:denominacao] = @denominacao if(@denomincao)
      serialized[:endereco] = @endereco if(@endereco)
      serialized[:lat] = @lat if(@lat)
      serialized[:long] = @long if(@long)
      serialized.to_json(*a)
  end


end
