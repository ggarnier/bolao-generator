require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'processador'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'bolao'))

processador = Processador.new("./bin/grupos.json")
grupos = processador.gerar_grupos
copa = Copa.new(grupos)
bolao = Bolao.new(copa)
bolao.chutar_resultados!

copa.grupos.each do |grupo|
  puts "Grupo #{grupo.nome}"
  puts "-------"
  grupo.jogos.each { |jogo| puts jogo.placar }
  puts ""

  puts "Classificação"
  puts "Posição\t\tTime                \tPontos"
  grupo.times.each_with_index do |time, index|
    puts "#{index+1}\t\t#{time.nome.ljust(20)}\t#{time.pontos}"
  end
  puts ""
  puts ""
end

puts "Oitavas de final"
puts "----------------"
puts copa.jogos_oitavas.map { |j| j.placar }
puts ""
puts ""

puts "Quartas de final"
puts "----------------"
puts copa.jogos_quartas.map { |j| j.placar }
puts ""
puts ""

puts "Semifinal"
puts "----------"
puts copa.jogos_semifinal.map { |j| j.placar }
puts ""
puts ""

jogo = copa.jogo_terceiro_lugar
terceiro_lugar = jogo.vencedor
puts "Decisão do terceiro lugar"
puts "-------------------------"
puts jogo.placar
puts "Terceiro lugar: #{terceiro_lugar.nome}"
puts ""
puts ""

puts "Final"
puts "-----"
puts copa.jogo_final.placar
puts "Campeao: #{copa.campeao.nome}"
