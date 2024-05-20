require 'rspec'
require 'fila'

RSpec.describe Banco do
  # Este bloco before(:each) é executado antes de cada teste, inicializando uma nova instância de Banco
  before(:each) do
    @banco = Banco.new
  end

  describe '#entrar' do
    it 'entra na fila' do
      # Testa se a chamada ao método `entrar` altera o tamanho da fila em 1
      expect { @banco.entrar("Lazaro") }.to change { @banco.instance_variable_get(:@fila).size }.by(1)
    end
  end

  describe '#sair' do
    it 'chama a pessoa' do
      @banco.entrar("Lazaro")
      expect { @banco.sair("Lazaro") }.to output("Última pessoa chamada Lazaro.\n").to_stdout
      expect(@banco.instance_variable_get(:@fila).size).to eq(0)
    end

    it 'informa que não há ninguém na fila' do
      expect { @banco.sair("Lazaro") }.to output("Não há ninguém na fila.\n").to_stdout
    end
  end

  describe '#exibir_fila' do
    it 'mostra a fila' do
      @banco.entrar("Lazaro")
      expect { @banco.exibir_fila }.to output("Ordem da fila:\n1. Lazaro\n").to_stdout
    end

    it 'exibe uma mensagem quando a fila está vazia' do
      expect { @banco.exibir_fila }.to output("Não há ninguém na fila.\n").to_stdout
    end
  end
end