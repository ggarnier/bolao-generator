class Selecao
  attr_reader :nome
  attr_accessor :pontos, :gols_pro, :gols_contra

  def initialize nome
    @nome = nome
    @pontos = 0
    @gols_pro = 0
    @gols_contra = 0
  end

  def saldo
    @gols_pro - @gols_contra
  end
end
