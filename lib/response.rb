

class Response

  def initialize(resp)
    @resp = resp
  end

  def model(path)
    #
    @resp = JSON.parse(@resp.body)

    if(@resp.respond_to?('has_key') && @resp.has_key?('code'))
      raise @resp['message']
    end

    case path
    when :signin
      token()
    when :linhas
      linhas()
    when :veiculos
      veiculos()
    when :veiculos_linha
      veiculos_linha()
    when :paradas
      paradas()
    when :paradas_linha
      paradas_linha()
    end
  end

  def token()
    @resp
  end

  def linhas()
    @resp.map{|l| Linha.new(l) }
  end

  def veiculos()
    v = @resp.map do |node|
      linha = Linha.new(node['Linha'])
      linha.veiculos
    end
    v.reduce(:concat)
  end

  def veiculos_linha()
    puts @resp
    linha = Linha.new(@resp['Linha'])
    linha.veiculos
  end

  def paradas ()
    @resp.map{|p| Parada.new(p) }
  end

  def paradas_linha()
    @resp = @resp['Linha'].merge!('Paradas' => @resp['Paradas'])
    Linha.new(@resp).paradas
  end

end