require 'rspec'
require 'calculo'

RSpec.describe Banco do
  let(:banco) { Banco.new }

  before do
    allow(Time).to receive(:now).and_return(Time.at(0), Time.at(10), Time.at(20), Time.at(30))
  end

  describe '#nova_senha' do
    it 'adiciona um novo cliente na fila e registra o tempo de entrada' do
      expect(banco.nova_senha("João")).to include("Bem-vindo João")
      expect(banco.fila).to include("João")
      expect(banco.tempos_entrada["João"]).to eq(Time.at(0))
    end
  end

  describe '#chamar_senha' do
    context 'quando a fila está vazia' do
      it 'informa que não há senhas para serem chamadas' do
        expect(banco.chamar_senha).to eq("Nenhuma senha para ser chamada.")
      end
    end

    context 'quando há clientes na fila' do
      before do
        banco.nova_senha("João")
        banco.nova_senha("Maria")
      end

      it 'chama a próxima senha e calcula o tempo de espera' do
        expect(banco.chamar_senha).to include("João foi atendido após 10.0 segundos de espera.")
        expect(banco.clientes_atendidos).to eq(1)
        expect(banco.tempo_ocupacao).to eq(10.0)
      end
    end
  end

  describe '#tempo_medio_espera' do
    context 'quando não há clientes atendidos' do
      it 'informa que não há clientes atendidos' do
        expect(banco.tempo_medio_espera).to eq("Não há clientes atendidos ainda.")
      end
    end

    context 'quando há clientes atendidos' do
      before do
        banco.nova_senha("João")
        banco.nova_senha("Maria")
        banco.chamar_senha
        allow(Time).to receive(:now).and_return(Time.at(40))
      end

      it 'calcula o tempo médio de espera' do
        expect(banco.tempo_medio_espera).to include("O tempo médio de espera é de 35.0 segundos.")
      end
    end
  end

  describe '#tempo_medio_sistema' do
    context 'quando não há clientes atendidos' do
      it 'informa que não há clientes atendidos' do
        expect(banco.tempo_medio_sistema).to eq("Não há clientes atendidos ainda.")
      end
    end

    context 'quando há clientes atendidos' do
      before do
        banco.nova_senha("João")
        banco.chamar_senha
      end

      it 'calcula o tempo médio no sistema' do
        expect(banco.tempo_medio_sistema).to include("O tempo médio no sistema é de 10.0 segundos.")
      end
    end
  end

  describe '#taxa_ocupacao_servidor' do
    context 'quando o tempo total de observação é zero' do
      it 'informa que não houve tempo total de observação' do
        expect(banco.taxa_ocupacao_servidor(0)).to eq("Não houve tempo total de observação.")
      end
    end

    context 'quando há tempo total de observação' do
      before do
        banco.nova_senha("João")
        banco.chamar_senha
      end

      it 'calcula a taxa de ocupação do servidor' do
        expect(banco.taxa_ocupacao_servidor(20)).to eq("A taxa de ocupação do servidor é de 50.0%.")
      end
    end
  end

  describe '#mostrar_fila' do
    context 'quando a fila está vazia' do
      it 'informa que a fila está vazia' do
        expect(banco.mostrar_fila).to eq("A fila está vazia.")
      end
    end

    context 'quando há clientes na fila' do
      before do
        banco.nova_senha("João")
        banco.nova_senha("Maria")
      end

      it 'mostra os clientes na fila' do
        expect(banco.mostrar_fila).to eq("Clientes na fila: João, Maria")
      end
    end
  end
end