require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'processador'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'bolao'))

processador = Processador.new("./bin/grupos.json")
grupos = processador.gerar_grupos

inicio = Time.now
contador = 0
begin
  contador += 1

  copa = Copa.new(grupos)
  bolao = Bolao.new(copa)
  bolao.chutar_resultados!
end while copa.campeao.nome != "Alemanha"

fim = Time.now
puts "Campeão chutado com sucesso após #{contador} tentativas e #{fim - inicio} segundos"
