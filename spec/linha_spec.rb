require 'spec_helper'

describe Linha do
  subject do
    Linha.new(
      {
        'Veiculos' => [{ 'codigoVeiculo' => 123 }],
        'Paradas' => [{ 'codigoParada' => 456 }]
      }
    )
  end

  context 'vehicles' do
    it 'should load as Veiculo object' do
      expect(subject.veiculos[0]).to be_an_instance_of(Veiculo)
    end

    it 'should set correct line' do
      expect(subject.veiculos[0].linha).to eq(subject)
    end
  end

  context 'stops' do
    it 'should load stops as Parada object' do
      expect(subject.paradas[0]).to be_an_instance_of(Parada)
    end

    it 'should set correct line' do
      expect(subject.paradas[0].linha).to eq(subject)
    end
  end
end
