require 'require_models'

class Token

  def initialize (key, fields={})
      @key = key
      @create_at = Time.now
      @minute_validate = fields[:minutes]
      @token = fields['token']
  end

  def date_in_format()
    today = Time.now
    today.strftime("%a, %d %b %Y %H:%M:%S GMT")
  end

  def header
    head ={}
    head['Accept-Language'] = "en"
    head['Content-Type'] = "application/json"
    head['X-Auth-Token'] = @token if @token
    head['X-Api-Key'] = @key
    head['Date'] = date_in_format()
    head
  end

  def valid?
    !@token.nil? && (Time.now - 10 * 60) <= @create_at
  end

  def to_json
    {
      'key' => @key,
      'token' => @token,
      'minute_validate' => @minute_validate
    }.to_json
  end
end
