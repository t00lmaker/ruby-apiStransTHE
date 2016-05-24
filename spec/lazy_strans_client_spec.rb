require 'rspec'
require 'json'
require 'require_models'


describe LazyStransClient do

  before(:example) do
    @client = LazyStransClient.new('luanpontes2@gmail.com', 'naul1991', '49ea6f5525a34e71bdd7b4f8a92adaac')
  end

  context '.linhas' do
    it "deve retornar paradas" do
      paradas = @client.paradas_proximas('-42.789010', '-5.114855', '1')
      expect(paradas).to_not be_nil
    end
  end

  context '.linhas_parada' do
    it "deve retornar paradas" do
      linhas = @client.linhas_parada('1137')
      expect(linhas).to_not be_nil
      expect(linhas.first.codigoLinha).to_not be_nil
    end
  end

end
