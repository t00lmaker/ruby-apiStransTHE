require 'net/http'
require 'json'
require 'linha'

class StransClient

  VERB_MAP = {
    :get    => Net::HTTP::Get,
    :post   => Net::HTTP::Post,
    :put    => Net::HTTP::Put,
    :delete => Net::HTTP::Delete
  }

  URL_API = "https://api.inthegra.strans.teresina.pi.gov.br/v1"

  def initialize( email, pass, key)
    @email = email
    @password = pass
    @key = key
  end

  def date_in_format()
    today = Time.now
    today.strftime("%a, %d %b %Y %H:%M:%S GMT")
  end

  def encode_path_params(path, params)
    encoded = URI.encode_www_form(params)
    [path, encoded].join("?")
  end

  def headers
    head ={
     'Content-Type' => "application/json",
     'Accept-Language' => "en",
     'Date' => date_in_format(),
     'X-Api-Key' => @key
    }
    head['X-Auth-Token'] = @token if(@token)
    head
  end

  def create_request ( method, path, params = nil )
    uri = URI.parse(URL_API+path)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    if(method == :get)
      uri.query = URI.encode_www_form(params) if (params)
    end
    req = VERB_MAP[method].new(uri, headers())
    if (params && method != :get)
      req.body = params.to_json
    end
    https.request(req)
  end

  def autentic
    body = { email: @email , password:  @password }
    res = create_request( :post, "/signin", body)
    if(res.code == '200')
      body = JSON.parse(res.body)
      @token = body["token"]
    end
    !@token.nil?
  end

  def linhas( busca = nil)
    params = busca.nil? ? nil :  {busca: busca}
    res = create_request( :get, "/linhas", params)
    JSON.parse(res.body).map{|l| Linha.new(l) }
  end

  def veiculos()
    res = create_request( :get, "/veiculos")
    veiculos = JSON.parse(res.body).map do |node|
      linha = Linha.new(node['Linha'])
      linha.veiculos
    end
    veiculos.reduce(:concat)
  end

  def veiculos_linha(num_linha)
    res = create_request( :get, "/veiculosLinha", {busca: num_linha})
    JSON.parse(res.body)
  end

  def paradas (busca = nil)
    params = busca.nil? ? nil :  {busca: busca}
    res = create_request( :get, "/paradas", params)
    JSON.parse(res.body).map{|p| Parada.new(p) }
  end

  def paradas_linha(num_linha)
    res = create_request( :get, "/paradasLinha", {busca: num_linha})
    result = JSON.parse(res.body)
    result = result['Linha'].merge!( 'Paradas' => result['Paradas'])
    Linha.new(result).paradas
  end

end
