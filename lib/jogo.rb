require File.expand_path(File.join(File.dirname(__FILE__), 'selecao'))

class Jogo
  attr_reader :time1, :time2, :gols_time1, :gols_time2, :desempate_nos_penaltis

  def initialize time1, time2, args = {}
    @time1 = time1
    @time2 = time2
    @gols_time1 = 0
    @gols_time2 = 0
    @penaltis_time1 = 0
    @penaltis_time2 = 0
    @desempate_nos_penaltis = args[:penaltis]
  end

  def atualizar_placar! gols_time1, gols_time2
    @gols_time1 = gols_time1
    @gols_time2 = gols_time2
    @time1.gols_pro += gols_time1
    @time1.gols_contra += gols_time2
    @time2.gols_pro += gols_time2
    @time2.gols_contra += gols_time1
  end

  def atualizar_penaltis! penaltis_time1, penaltis_time2
    @penaltis_time1 = penaltis_time1
    @penaltis_time2 = penaltis_time2
  end

  def placar
    if empate? && @desempate_nos_penaltis
      "#{@time1.nome} #{@gols_time1} (#{@penaltis_time1}) x (#{@penaltis_time2}) #{@gols_time2} #{@time2.nome}"
    else
      "#{@time1.nome} #{@gols_time1} x #{@gols_time2} #{@time2.nome}"
    end
  end

  def vencedor
    if empate?
      if @desempate_nos_penaltis
        vencedor_penaltis
      else
        nil
      end
    elsif @gols_time1 > @gols_time2
      @time1
    else
      @time2
    end
  end

  def empate?
    @gols_time1 == @gols_time2
  end

  private

  def vencedor_penaltis
    @penaltis_time1 > @penaltis_time2 ? @time1 : @time2
  end
end
