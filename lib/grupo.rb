class Grupo
  attr_reader :nome, :times

  def initialize attrs = {}
    @nome = attrs["grupo"]
    @times = attrs["times"]
  end

  def jogos
    @times.combination(2).map do |tupla|
      "#{tupla.first} x #{tupla.last}"
    end
  end
end
