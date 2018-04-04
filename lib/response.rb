require_relative 'linha'
require_relative 'parada'

class Response

  def initialize(resp)
    @resp = resp
  end

  def model(path)
    @resp = JSON.parse(@resp.body)
    case path
    when :signin
      token
    when :linhas
      linhas
    when :veiculos
      veiculos
    when :veiculos_linha
      veiculos_linha
    when :paradas
      paradas
    when :paradas_linha
      paradas_linha
    end
  end

  def token
    @resp
  end

  def linhas
    @resp.map{ |l| LinhaStrans.new(l) }
  end

  def veiculos
    v = @resp.map do |node|
      linha = LinhaStrans.new(node['Linha'])
      linha.veiculos
    end
    v.reduce(:concat)
  end

  def veiculos_linha
    linha = LinhaStrans.new(@resp['Linha'])
    linha.veiculos
  end

  def paradas
    @resp.map{|p| ParadaStrans.new(p) }
  end

  def paradas_linha
    @resp.map{|p| ParadaStrans.new(p) }
  end

end
