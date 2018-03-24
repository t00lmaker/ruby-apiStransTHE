require 'json'
require 'require_models'

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
    uri = URI.parse(URL_API + path)
    if(method == :get)
      uri.query = URI.encode_www_form(params) if (params)
    end
    Net::HTTP.start(uri.host, uri.port,  :use_ssl => true) do |https|
      req = VERB_MAP[method].new(uri, @token.header)
      if params && method != :get
        req.body = params.to_json

      resp = https.request(req)
      case resp
      when Net::HTTPSuccess then
        Response.new(resp)
      else 
        Erro.new(code: resp.code, message: resp.message)
      end
    end
  end

end