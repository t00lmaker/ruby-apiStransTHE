require 'json'
require 'net/http'
require_relative 'response'
require_relative 'erro'

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

  def send(method, path, params = nil)
    uri = URI.parse(URL_API + path)
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |https|
      req = build_request(method, uri, params)
      build_response(https.request(req))
    end
  end

  private

  def build_request(method, uri, params)
    uri.query = URI.encode_www_form(params) if method == :get && params
    req = VERB_MAP[method].new(uri, @token.header)
    req.body = params.to_json if params && method != :get
    req
  end

  def build_response(resp_http)
    case resp_http
    when Net::HTTPSuccess then
      Response.new(resp_http)
    else
      ErroStrans.new(code: resp_http.code, message: resp_http.message)
    end
  end
end
