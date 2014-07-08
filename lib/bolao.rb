require File.expand_path(File.join(File.dirname(__FILE__), 'copa'))

class Bolao
  attr_reader :copa

  def initialize copa
    @copa = copa
  end

  def chutar!
    chutar_primeira_fase!
  end

  private
  def gerar_random
    rand(5)
  end

  def chutar_primeira_fase!
    @copa.jogos_primeira_fase.map do |jogo|
      jogo.atualizar_placar!(gerar_random, gerar_random)
      jogo.placar
    end

    @copa.grupos.each { |grupo| grupo.atualizar_classificacao! }
  end
end
