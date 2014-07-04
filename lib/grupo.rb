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
end
