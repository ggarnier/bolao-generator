require File.expand_path(File.join(File.dirname(__FILE__), 'jogo'))
require File.expand_path(File.join(File.dirname(__FILE__), 'selecao'))

class Grupo
  attr_reader :nome, :times

  def initialize attrs = {}
    @nome = attrs["grupo"]
    @times = attrs["times"].map { |nome| Selecao.new(nome) }
  end

  def jogos
    @jogos ||= @times.combination(2).map do |tupla|
      Jogo.new(tupla.first, tupla.last)
    end
  end

  def atualizar_classificacao!
    zerar_pontuacao

    jogos.each do |jogo|
      time1 = @times.select { |time| time == jogo.time1 }.first
      time2 = @times.select { |time| time == jogo.time2 }.first
      if jogo.gols_time1 > jogo.gols_time2
        time1.pontos += 3
      elsif jogo.gols_time1 == jogo.gols_time2
        time1.pontos += 1
        time2.pontos += 1
      else
        time2.pontos += 3
      end
    end

    reordenar_times
  end

  def classificados
    @times[0,2]
  end

  private
  def zerar_pontuacao
    @times.each { |time| time.pontos = 0 }
  end

  def reordenar_times
    @times = @times.sort do |a, b|
      comp = (b.pontos <=> a.pontos)
      comp.zero? ? (b.saldo <=> a.saldo) : comp
    end
  end
end
