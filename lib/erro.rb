

class Erro

  def initialize(fields)
    @code = fields['code']
    @message = fields['message']
  end

  def to_json(*a)
    error = Hash.new
    error[:code] = @error if @error
    error[:message] = @message if @message
    error.to_json
  end

end
