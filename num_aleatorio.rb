#geração de números aleatórios que simulem a chegada de clientes na fila

class Banco

  def initialize
    @fila = {}
  end
  
  def nova_senha(nome)
    num_senha = rand(200)
    @fila[num_senha] = nome
    puts "Bem-vindo #{nome}, sua senha é #{num_senha}"
  end

  def chamar_senha
    if @fila.empty?
      puts "Nenhuma senha para ser atendida."
    else 
      num_senha, cliente_atendido = @fila.shift
      puts "#{cliente_atendido} foi atendido número da senha #{num_senha}"
    end 
  end 

  def exibir_fila
    if @fila.empty?
      puts "Nenhuma senha para ser atendida."
    else 
      puts "Senhas a serem chamadas: "
      @fila.each do |senha, cliente|
        puts "Senha #{senha}: #{cliente}"
      end
    end
  end  
end

fila_banco = Banco.new

fila_banco.exibir_fila

fila_banco.nova_senha("João")
fila_banco.nova_senha("Maria")
fila_banco.nova_senha("Marta")

fila_banco.exibir_fila

