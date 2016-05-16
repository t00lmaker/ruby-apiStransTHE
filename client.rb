require 'net/http'
require 'json'

class BasicClinet

  def initialize( email, pass, key)
    @email = email
    @password = pass
    @key = key
  end

  URL_API = "https://api.inthegra.strans.teresina.pi.gov.br/v1"

  def uri( path )
    URI.parse(URL_API+path)
  end

  #"Wed, 13 Apr 2016 12:07:37 GMT"
  def date_in_format()
    today = Time.now
    today.strftime("%a, %d %b %Y %H:%M:%S GMT")
  end

  def headers
    #head = Hash.new
    #head ['Content-Type'] = "application/json",
    #head ['Accept-Language'] = "en",
    #head ['Date'] = date_in_format(),
    #head ['X-Api-Key'] = @key
    #head['X-Auth-Token'] = @token if(@token)
    #head
   {
     'Content-Type' => "application/json",
     'Accept-Language' => "en",
     'Date' => date_in_format(),
     'X-Api-Key' => @key
    }
  end

  def create_request ( method, path, body = nil   )
    uri = uri(path)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, headers())
    req.body = body if ( body )
    https.request(req)
  end

  def autentic
    body = "{\"email\": \"#{@email}\", \"password\": \"#{@password}\"}"
    res = create_request( "POST","/signin", body)
    if(res.code == '200')
      body = JSON.parse(res.body)
      @token = body["token"]
    end
    !@token.nil?
  end

  def linhas
    res = create_request( "GET","/linhas")
    JSON.parse(res.body)
  end

end

cliente = BasicClinet.new('luanpontes2@gmail.com', 'naul1991', '49ea6f5525a34e71bdd7b4f8a92adaac')
puts cliente.autentic()
