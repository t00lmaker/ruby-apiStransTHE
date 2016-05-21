
require 'rspec'
require 'require_models'
require 'json'


describe StransClient do

  before(:example) do
    @client = StransClient.new('luanpontes2@gmail.com', 'naul1991', '49ea6f5525a34e71bdd7b4f8a92adaac')
  end

  context '.linhas' do
    it 'deve retornar instancias de Linha' do
      linhas = @client.get(:linhas)
      expect(linhas).to be_an_instance_of(Array)
      expect(linhas.size).to be > 0
      expect(linhas[0]).to be_an_instance_of(Linha)
      expect(linhas[0]).to_not be_nil
      expect(linhas[0].codigoLinha).to_not be_nil
    end
  end

  context '.paradas' do
    it 'deve retornar instancias de Linha' do
      paradas = @client.get(:paradas)
      puts paradas.to_json
      expect(paradas).to be_an_instance_of(Array)
      expect(paradas.size).to be > 0
      expect(paradas[0]).to be_an_instance_of(Parada)
      expect(paradas[0]).to_not be_nil
      expect(paradas[0].codigoParada).to_not be_nil
    end
  end

  context '.veiculos' do
    it 'deve retornar instancias de Veiculo' do
      veiculos = @client.get(:veiculos)
      expect(veiculos).to be_an_instance_of(Array)
      expect(veiculos.size).to be > 0
      veiculo = veiculos.first
      expect(veiculo).to be_an_instance_of(Veiculo)
      expect(veiculo).to_not be_nil
      expect(veiculo.codigoVeiculo).to_not be_nil
      expect(veiculo.linha).to_not be_nil
      expect(veiculo.linha.codigoLinha).to_not be_nil
    end
  end

  context '.paradas_linha' do
    it 'deve retornar instancias de Veiculo' do
      codigoLinha = '0402'
      paradas = @client.get(:paradas_linha, codigoLinha)
      expect(paradas).to be_an_instance_of(Array)
      expect(paradas.size).to be > 0
      parada = paradas.first
      expect(parada).to be_an_instance_of(Parada)
      expect(parada).to_not be_nil
      expect(parada.codigoParada).to_not be_nil
      expect(parada.linha).to_not be_nil
      expect(parada.linha.codigoLinha).to_not be_nil
      expect(parada.linha.codigoLinha).to eql(codigoLinha)
    end
  end

  #pode da error de veiculo nao encontrado
  context '.veiculos_linha' do
    it 'deve retornar instancias de Veiculo' do
      codigoLinha = '0403'
      veiculos = @client.get(:veiculos_linha,codigoLinha)
      expect(veiculos).to be_an_instance_of(Array)
      expect(veiculos.size).to be > 0
      veiculo = veiculos.first
      expect(veiculo).to be_an_instance_of(Veiculo)
      expect(veiculo).to_not be_nil
      expect(veiculo.codigoVeiculo).to_not be_nil
      expect(veiculo.linha).to_not be_nil
      expect(veiculo.linha.codigoLinha).to_not be_nil
      expect(veiculo.linha.codigoLinha).to eql(codigoLinha)
    end
  end

  context '.to_json deve retornar um json' do
    it 'deve retornar instancias de Veiculo' do
      linhas = @client.get(:linhas)
      JSON.parse(linhas.to_json)
      codigoLinha = '0403'
      veiculos = @client.get(:veiculos_linha, codigoLinha)
      JSON.parse(veiculos.to_json)
      paradas = @client.get(:paradas)
      JSON.parse(paradas.to_json)
      paradas = @client.get(:paradas_linha, codigoLinha)
      JSON.parse(paradas.to_json)
    end
  end

end
