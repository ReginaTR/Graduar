#Cálculo de tempo médio de espera, tempo médio no sistema e taxa de ocupação do servidor.

class Banco
    def initialize
        @fila = []
        @tempos_entrada = {}
        @tempo_ocupacao = 0
        @clientes_atendidos = 0
    end 

    def nova_senha(nome)
        num_senha = rand(200)
        @fila << nome
        @tempos_entrada[nome] = Time.now
        puts "Bem-vindo #{nome}, sua senha é: #{num_senha}."
    end 

    def chamar_senha
        if @fila.empty?
            puts "Nenhuma senha para ser chamada."
        else 
            cliente_atendido = @fila.shift
            tempo_entrada = @tempos_entrada[cliente_atendido]
            tempo_espera = Time.now - tempo_entrada
            @tempo_ocupacao += tempo_espera
            @clientes_atendidos += 1
            puts "#{cliente_atendido} foi atendido após #{tempo_espera} segundos de espera."
        end 
    end
    
    def tempo_medio_espera
        if @tempos_entrada.empty?
            puts "Não há clientes atendidos ainda."
        else 
            tempos_espera = @tempos_entrada.map {|cliente, tempo| Time.now - tempo}
            tempo_medio_espera = tempos_espera.reduce(:+) / tempos_espera.size
            puts "O tempo médio de espera é de #{tempo_medio_espera} segundos."
        end 
    end        
    
    def tempo_medio_sistema
        if @clientes_atendidos == 0
            puts "Não há clientes atendidos ainda."
        else
            tempo_medio_sistema = @tempo_ocupacao / @clientes_atendidos
            puts "O tempo médio no sistema é de #{tempo_medio_sistema} segundos."
        end    
    end    

    def taxa_ocupacao_servidor(tempo_total)
        if tempo_total == 0
            puts "Não houve tempo total de observação."
        else
            taxa_ocupacao = @tempo_ocupacao / tempo_total
            puts "A taxa de ocupação do servidor é de #{taxa_ocupacao * 100}%."
        end
    end

    def mostrar_fila
        if @fila.empty?
            puts "A fila está vazia."
        else
            puts "Clientes na fila: "
            @fila.each {|cliente| puts cliente }
        end
    end
end

fila_banco = Banco.new



fila_banco.nova_senha("João")
fila_banco.nova_senha("Maria")
fila_banco.nova_senha("Marta")

tempo_total = 0
5.times do
  fila_banco.chamar_senha
  tempo_total += 1
end

fila_banco.mostrar_fila
fila_banco.tempo_medio_espera
fila_banco.tempo_medio_sistema
fila_banco.taxa_ocupacao_servidor(tempo_total)
