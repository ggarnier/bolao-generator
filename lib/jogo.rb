class Jogo
  def initialize time1, time2
    @time1 = time1
    @time2 = time2
    @gols_time1 = 0
    @gols_time2 = 0
  end

  def atualizar_placar gols_time1, gols_time2
    @gols_time1 = gols_time1
    @gols_time2 = gols_time2
  end

  def placar
    "#{@time1.nome} #{@gols_time1} x #{@gols_time2} #{@time2.nome}"
  end
end
