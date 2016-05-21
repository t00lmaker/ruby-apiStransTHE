require 'rspec'
require 'require_models'
require 'json'

describe ManagerData do

  before(:example) do
    @client = ManagerData.new('luanpontes2@gmail.com', 'naul1991', '49ea6f5525a34e71bdd7b4f8a92adaac')
  end

  context '.linhas' do
    it "deve retornar paradas" do
      paradas = @client.parada_form(-42.789010, -5.114855, 1)
      expect(paradas).to_not be_nil
      puts paradas.size.to_s
    end
  end


end
