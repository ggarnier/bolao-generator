require File.expand_path(File.join(File.dirname(__FILE__), 'grupo'))

class Copa
  attr_reader :grupos

  def initialize grupos
    @grupos = grupos
  end

  def jogos_primeira_fase
    @jogos ||= @grupos.map(&:jogos).flatten
  end

  def atualizar_classificacao_primeira_fase!
    @grupos.each { |grupo| grupo.atualizar_classificacao! }
  end

  def jogos_oitavas
    @jogos_oitavas ||= begin
      ordem_grupos.map.each do |i|
        j = (i.even? ? i+1 : i-1)
        Jogo.new(@grupos.at(i).classificados.first, @grupos.at(j).classificados.last)
      end
    end
  end

  def jogos_quartas
    @jogos_quartas ||= begin
      times_classificados = jogos_oitavas.map { |j| j.vencedor(penaltis: true) }
      (0..3).map do |i|
        Jogo.new(times_classificados.at(i), times_classificados.at(i+4))
      end
    end
  end

  private

  def ordem_grupos
    ordem = (0...@grupos.size).to_a
    ordem.select { |a| a.even? } + ordem.select { |a| a.odd? }
  end
end
