require 'json'

class Request

  URL_API = "https://api.inthegra.strans.teresina.pi.gov.br/v1"

  VERB_MAP = {
    :get    => Net::HTTP::Get,
    :post   => Net::HTTP::Post,
    :put    => Net::HTTP::Put,
    :delete => Net::HTTP::Delete
  }
  def initialize(token)
    @token = token
  end

  def encode_path_params(path, params)
    encoded = URI.encode_www_form(params)
    [path, encoded].join("?")
  end

  def send( method, path, params = nil )
    uri = URI.parse(URL_API+path)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    if(method == :get)
      uri.query = URI.encode_www_form(params) if (params)
    end
    req = VERB_MAP[method].new(uri, @token.header)
    if (params && method != :get)
      req.body = params.to_json
    end
    Response.new(https.request(req))
  end

end
