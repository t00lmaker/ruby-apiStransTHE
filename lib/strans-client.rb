require 'json'
require_relative 'request'
require_relative 'response'
require_relative 'token'
require_relative 'erro'

class StransClient

  PATHS = {
    signin: '/signin',
    linhas: '/linhas',
    veiculos: '/veiculos',
    veiculos_linha: '/veiculosLinha',
    paradas: '/paradas',
    paradas_linha: '/paradas'
  }.freeze

  def initialize(email, pass, key)
    @email = email
    @password = pass
    @key = key
    @token = TokenStrans.new(@key)
  end

  def get(path, busca = nil)
    @request = Request.new(@token)
    if @token.valid?
      busca = busca.nil? ? {} : {busca: busca}
      @resp = @request.send(:get, PATHS[path], busca)
      @resp = @resp.model(path) if @resp.is_a? Response
    else
      @resp = autentic
      get(path, busca) if @token.valid?
    end
    @resp
  end

  private

  def autentic
    credencials = { email:@email, password:@password }
    @resp = @request.send(:post, PATHS[:signin], credencials)
    @token = TokenStrans.new(@key, @resp.model(:signin)) unless @resp.is_a? ErroStrans
    @resp
  end

end
