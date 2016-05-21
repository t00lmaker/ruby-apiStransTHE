
require 'net/http'
require 'json'
require 'require_models'

class StransClient

  PATHS = {
    :signin  => '/signin',
    :linhas => '/linhas',
    :veiculos => '/veiculos',
    :veiculos_linha => '/veiculosLinha',
    :paradas => '/paradas',
    :paradas_linha => '/paradasLinha',
  }

  def initialize( email, pass, key)
    @email = email
    @password = pass
    @key = key
    @token = Token.new(@key)
  end

  def get(path, busca = nil )
    @request = Request.new(@token)
    if(@token.valid?)
      busca = busca.nil? ? {} :  {busca: busca}
      @resp  = @request.send(:get, PATHS[path], busca)
      @resp.model(path)
    else
      autentic()
      get(path, busca)
    end
  end

  private

  def autentic
    credencials = { email:@email, password:@password }
    @resp = @request.send(:post, PATHS[:signin], credencials)
    @token = Token.new(@key, @resp.model(:signin))
  end

end
