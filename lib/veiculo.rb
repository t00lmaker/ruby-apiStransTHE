require 'require_models'

class Veiculo

  attr_accessor :codigoVeiculo, :hora, :lat, :long, :linha

  def initialize(fields)
    if(fields)
      @codigoVeiculo  = fields['CodigoVeiculo'] || fields[:codigoVeiculo]
      @hora           = fields['Hora'] || fields[:hora]
      @lat            = (fields['Lat']  || fields[:lat]).to_f
      @long           = (fields['Long'] || fields[:long]).to_f
    end
  end

  def to_json(*a)
    att()
    serialized = Hash.new
    serialized[:codigoVeiculo] = @codigoVeiculo if(@codigoVeiculo)
    serialized[:hora] = @hora if(@hora)
    serialized[:lat] = @lat if(@lat)
    serialized[:long] = @long if(@long)
    serialized.to_json(*a)
  end

end
