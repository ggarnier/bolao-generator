require File.expand_path(File.join(File.dirname(__FILE__), 'grupo'))

class Copa
  attr_reader :grupos

  def initialize grupos
    @grupos = grupos
  end

  def jogos_primeira_fase
    @jogos ||= @grupos.map(&:jogos).flatten
  end

  def atualizar_classificacao!
    @grupos.each { |grupo| grupo.atualizar_classificacao! }
  end

  def jogos_oitavas
    @jogos_oitavas ||= begin
      @grupos.map.each_with_index do |_, i|
        j = (i.even? ? i+1 : i-1)
        Jogo.new(@grupos.at(i).classificados.first, @grupos.at(j).classificados.last)
      end
    end
  end
end
