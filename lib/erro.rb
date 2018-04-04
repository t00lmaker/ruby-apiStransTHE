
# Encapsula um erro de requisicao
class ErroStrans
  def initialize(fields)
    @code = fields[:code] || fields['code']
    @message = fields[:message] || fields['message']
  end

  def to_json
    map.to_json
  end

  def map
    error = {}
    error[:code] = @error if @error
    error[:message] = @message if @message
  end
end
