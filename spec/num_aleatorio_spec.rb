require 'rspec'
require 'num_aleatorio'  # Ajuste o caminho se necessário

RSpec.describe Banco do
  before(:each) do
    @banco = Banco.new
  end

  describe '#nova_senha' do
    it 'adiciona uma nova senha à fila' do
      expect { @banco.nova_senha("João") }.to change { @banco.instance_variable_get(:@fila).size }.by(1)
    end
  end

  describe '#chamar_senha' do
    it 'chama a próxima senha da fila' do
      @banco.nova_senha("João")
      @banco.nova_senha("Maria")
      expect { @banco.chamar_senha }.to change { @banco.instance_variable_get(:@fila).size }.by(-1)
    end
    
    it 'exibe uma mensagem quando não há senhas na fila' do
      expect { @banco.chamar_senha }.to output("Nenhuma senha para ser atendida.\n").to_stdout
    end
  end

  describe '#exibir_fila' do
    it 'exibe as senhas na fila' do
      @banco.nova_senha("João")
      expect { @banco.exibir_fila }.to output(/Senhas a serem chamadas:/).to_stdout
    end
    
    it 'exibe uma mensagem quando a fila está vazia' do
      expect { @banco.exibir_fila }.to output("Nenhuma senha para ser atendida.\n").to_stdout
    end
  end
end