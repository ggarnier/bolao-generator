require File.expand_path(File.join(File.dirname(__FILE__), 'copa'))

class Bolao
  attr_reader :copa

  def initialize copa
    @copa = copa
  end

  def chutar_primeira_fase!
    @copa.jogos_primeira_fase.each do |jogo|
      chutar_jogo(jogo)
    end

    @copa.atualizar_classificacao_primeira_fase!
  end

  def chutar_oitavas!
    @copa.jogos_oitavas.each do |jogo|
      chutar_jogo(jogo, penaltis: true)
    end
  end

  def chutar_quartas!
    @copa.jogos_quartas.each do |jogo|
      chutar_jogo(jogo, penaltis: true)
    end
  end

  def chutar_semifinal!
    @copa.jogos_semifinal.each do |jogo|
      chutar_jogo(jogo, penaltis: true)
    end
  end

  def chutar_final!
    chutar_jogo(@copa.jogo_final, penaltis: true)
  end

  def chutar_jogo jogo, args = {}
    jogo.atualizar_placar!(gerar_random, gerar_random)

    if jogo.empate? && args[:penaltis]
      chutar_disputa_penaltis(jogo)
    end
  end

  def chutar_disputa_penaltis jogo
    begin
      penaltis_time1 = gerar_random
      penaltis_time2 = gerar_random
    end while penaltis_time1 == penaltis_time2

    jogo.atualizar_penaltis!(penaltis_time1, penaltis_time2)
  end

  private

  def gerar_random
    rand(5)
  end

  def gerar_random_penaltis

  end
end
