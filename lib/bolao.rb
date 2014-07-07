require File.expand_path(File.join(File.dirname(__FILE__), 'copa'))

class Bolao
  attr_reader :copa

  def initialize copa
    @copa = copa
  end

  def chutar!
    @copa.jogos.map do |jogo|
      jogo.atualizar_placar!(gerar_random, gerar_random)
      jogo.placar
    end
  end

  private
  def gerar_random
    rand(5)
  end
end
