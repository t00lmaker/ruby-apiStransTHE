require 'spec_helper'

describe StransClient do
  before(:example) do
    VCR.use_cassette('auth') do
      client.autentic
    end
  end

  let(:client) do
    StransClient.new('user@example.com', 'secret', 'aaaaabbbbbcccccdddddeeeeefffffgg')
  end

  context '.linhas' do
    before do
      VCR.use_cassette('lines') do
        lines
      end
    end

    let(:lines) do
      client.linhas
    end

    it 'should return an instance of Array' do
      expect(lines).to be_an_instance_of(Array)
    end

    it 'is expected not to be empty' do
      expect(lines).not_to be_empty
    end

    it 'is exected elements to be instance of Linha' do
      expect(lines[0]).to be_an_instance_of(Linha)
    end
  end

  context '.paradas' do
    before do
      VCR.use_cassette('stops') do
        stops
      end
    end

    let(:stops) do
      client.paradas
    end

    it 'should return an instance of Array' do
      expect(stops).to be_an_instance_of(Array)
    end

    it 'should not return a empty array' do
      expect(stops).not_to be_empty
    end

    it 'is exected elements to be instance of Parada' do
      expect(stops[0]).to be_an_instance_of(Parada)
    end
  end

  context '.veiculos' do
    before do
      VCR.use_cassette('vehicles') do
        vehicles
      end
    end

    let(:vehicles) do
      client.veiculos
    end

    it 'should return an instance of Array' do
      expect(vehicles).to be_an_instance_of(Array)
    end

    it 'should not return an empty array' do
      expect(vehicles).not_to be_empty
    end

    it 'is exected elements to be instance of Veiculo' do
      expect(vehicles[0]).to be_an_instance_of(Veiculo)
    end
  end

  context '.paradas_linha' do
    before do
      VCR.use_cassette('stop-and-line') do
        stop
      end
    end

    let(:stop) do
      client.paradas_linha('0402')
    end

    it 'should return an Array' do
      expect(stop).to be_an_instance_of(Array)
    end

    it 'should not return an empty array' do
      expect(stop).not_to be_empty
    end

    it 'should return elements as instances of Parada' do
      expect(stop[0]).to be_an_instance_of(Parada)
    end
  end
end
