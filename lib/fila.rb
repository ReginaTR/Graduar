# Implementação de uma simulação básica de fila de  atendimento, como em um banco ou supermercado.

class Banco
    
    def initialize
        @fila = []
    end

    def entrar(nome)
        @fila.push(nome)
        puts "#{nome} entrou na fila."
    end

    def sair(nome)
        if @fila.empty? 
            puts "Não há ninguém na fila."
        else 
            pessoa = @fila.shift
            puts "Última pessoa chamada #{pessoa}."
        end
    end

    def exibir_fila
        if @fila.empty?
            puts "Não há ninguém na fila."
        else 
            puts "Ordem da fila:"
            @fila.each_with_index do |nome, index|
                puts "#{index + 1}. #{nome}"
            end 
        end
    end
end

fila_banco = Banco.new

fila_banco.entrar("Maria")
fila_banco.entrar("Lázaro")
fila_banco.entrar("Marta")

fila_banco.exibir_fila

fila_banco.sair("Maria")

fila_banco.exibir_fila

 