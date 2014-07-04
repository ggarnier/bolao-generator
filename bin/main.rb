require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'processador'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'bolao'))

processador = Processador.new("./bin/grupos.json")
grupos = processador.gerar_grupos
copa = Copa.new(grupos)
bolao = Bolao.new(copa)
bolao.chutar!
copa.grupos.each do |grupo|
  puts "Grupo #{grupo.nome}"
  puts "-------"
  grupo.jogos.each {|jogo| puts jogo.placar}
  puts ""
end