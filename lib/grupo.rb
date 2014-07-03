class Grupo
  attr_reader :nome, :times

  def initialize attrs = {}
    @nome = attrs["grupo"]
    @times = attrs["times"]
  end
end
