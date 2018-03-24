require 'json'
require 'require_models'

# Representa uma requisicao
class Request
  URL_API = 'https://api.inthegra.strans.teresina.pi.gov.br/v1'.freeze

  VERB_MAP = {
    get: Net::HTTP::Get,
    post: Net::HTTP::Post,
    put:   Net::HTTP::Put,
    delete: Net::HTTP::Delete
  }.freeze

  def initialize(token)
    @token = token
  end

  def encode_path_params(path, params)
    encoded = URI.encode_www_form(params)
    [path, encoded].join('?')
  end

  def send( method, path, params = nil )
    uri = URI.parse(URL_API + path)
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |https|
      req = VERB_MAP[method].new(uri, @token.header)
      build_params(method, uri, params, req)
      build_response(https.request(req))
    end
  end

  private

  def build_params(method, uri, params, req)
    uri.query = URI.encode_www_form(params) if method == :get && params
    req.body = params.to_json if params && method != :get
  end

  def build_response(resp_http)
    case respHttp
    when Net::HTTPSuccess then
      Response.new(resp_http)
    else
      Erro.new(code: resp_http.code, message: resp_http.message)
    end
  end

end
