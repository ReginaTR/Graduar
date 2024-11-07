require 'rspec'
require 'calculo'

RSpec.describe Banco do
  let(:banco) { Banco.new }

  describe '#nova_senha' do
    it 'adiciona um cliente à fila com um número de senha' do
      expect { banco.nova_senha('João') }.to output(/Bem-vindo João, sua senha é: \d+\./).to_stdout
      expect(banco.instance_variable_get(:@fila)).to include('João')
      expect(banco.instance_variable_get(:@tempos_entrada)).to have_key('João')
    end
  end

  describe '#chamar_senha' do
    it 'atende o próximo cliente na fila e calcula o tempo de espera' do
      banco.nova_senha('Maria')
      allow(Time).to receive(:now).and_return(Time.now + 5)
      expect { banco.chamar_senha }.to output(/Maria foi atendido após 5\.0\d* segundos de espera\./).to_stdout
      expect(banco.instance_variable_get(:@fila)).not_to include('Maria')
    end

    it 'informa que não há senhas para serem chamadas se a fila estiver vazia' do
      expect { banco.chamar_senha }.to output(/Nenhuma senha para ser chamada\./).to_stdout
    end
  end

  describe '#tempo_medio_espera' do
    it 'calcula e imprime o tempo médio de espera' do
      banco.nova_senha('João')
      banco.nova_senha('Maria')
      allow(Time).to receive(:now).and_return(Time.now + 5)
      banco.chamar_senha
      banco.chamar_senha
      expect { banco.tempo_medio_espera }.to output(/O tempo médio de espera é de 5\.0\d* segundos\./).to_stdout
    end

    it 'informa que não há clientes atendidos se a fila estiver vazia' do
      expect { banco.tempo_medio_espera }.to output(/Não há clientes atendidos ainda\./).to_stdout
    end
  end

  describe '#tempo_medio_sistema' do
    it 'calcula e imprime o tempo médio no sistema' do
      banco.nova_senha('João')
      banco.nova_senha('Maria')
      allow(Time).to receive(:now).and_return(Time.now + 5)
      banco.chamar_senha
      banco.chamar_senha
      expect { banco.tempo_medio_sistema }.to output(/O tempo médio no sistema é de 5\.0\d* segundos\./).to_stdout
    end

    it 'informa que não há clientes atendidos ainda' do
      expect { banco.tempo_medio_sistema }.to output(/Não há clientes atendidos ainda\./).to_stdout
    end
  end

  describe '#taxa_ocupacao_servidor' do
    it 'calcula e imprime a taxa de ocupação do servidor' do
      banco.nova_senha('João')
      allow(Time).to receive(:now).and_return(Time.now + 5)
      banco.chamar_senha
      expect { banco.taxa_ocupacao_servidor(10) }.to output(/A taxa de ocupação do servidor é de 50\.0\d*%/).to_stdout
    end

    it 'informa que não houve tempo total de observação se tempo_total for zero' do
      expect { banco.taxa_ocupacao_servidor(0) }.to output(/Não houve tempo total de observação\./).to_stdout
    end
  end

  describe '#mostrar_fila' do
    it 'exibe a lista de clientes na fila' do
      banco.nova_senha('João')
      banco.nova_senha('Maria')
      expect { banco.mostrar_fila }.to output(/Clientes na fila:.*João.*Maria/m).to_stdout
    end

    it 'informa que a fila está vazia' do
      expect { banco.mostrar_fila }.to output(/A fila está vazia\./).to_stdout
    end
  end
end