require File.expand_path(File.join(File.dirname(__FILE__), 'copa'))

class Bolao
  attr_reader :copa

  def initialize copa
    @copa = copa
  end

  def chutar_primeira_fase!
    @copa.jogos_primeira_fase.map do |jogo|
      chutar_jogo(jogo)
      jogo.placar
    end

    @copa.atualizar_classificacao!
  end

  def chutar_oitavas!
    @copa.jogos_oitavas.each do |jogo|
      chutar_jogo(jogo)
    end
  end

  private
  def chutar_jogo(jogo)
    jogo.atualizar_placar!(gerar_random, gerar_random)
  end

  def gerar_random
    rand(5)
  end
end
