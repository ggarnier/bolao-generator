require File.expand_path(File.join(File.dirname(__FILE__), 'grupo'))

class Bolao
  attr_reader :grupos

  def initialize grupos
    @grupos = grupos
  end

  def chutar!
    jogos.map do |jogo|
      jogo.atualizar_placar(gerar_random, gerar_random)
      jogo.placar
    end
  end

  def jogos
    @jogos ||= @grupos.map(&:jogos).flatten
  end

  private
  def gerar_random
    rand(5)
  end
end
