require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'processador'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'bolao'))

def benchmark
  processador = Processador.new("./bin/grupos.json")
  grupos = processador.gerar_grupos

  inicio = Time.now
  contador = 0

  begin
    contador += 1

    copa = Copa.new(grupos)
    bolao = Bolao.new(copa)
    bolao.chutar_resultados!
  end until yield(copa)

  fim = Time.now
  puts "Resultado chutado com sucesso após #{contador} tentativas e #{fim - inicio} segundos"
end

puts "Alemanha campeã"
benchmark { |copa| copa.campeao.nome == "Alemanha" }
puts ""

puts "Final entre Alemanha e Argentina"
benchmark { |copa| [copa.jogo_final.time1.nome, copa.jogo_final.time2.nome].sort == ["Alemanha", "Argentina"] }
puts ""

puts "Placar exato da final entre Alemanha e Argentina"
benchmark do |copa|
  final = copa.jogo_final
  final.placar == "Alemanha 1 x 0 Argentina" || final.placar == "Argentina 0 x 1 Alemanha"
end
