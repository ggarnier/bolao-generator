require File.expand_path(File.join(File.dirname(__FILE__), 'grupo'))

class Copa
  attr_reader :grupos

  def initialize grupos
    @grupos = grupos
  end

  def jogos
    @jogos ||= @grupos.map(&:jogos).flatten
  end
end
