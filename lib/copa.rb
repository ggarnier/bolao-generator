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
      ordem_cruzamento_grupos.map.each do |i|
        j = (i.even? ? i+1 : i-1)
        Jogo.new(@grupos.at(i).classificados.first, @grupos.at(j).classificados.last)
      end
    end
  end

  def jogos_quartas
    @jogos_quartas ||= begin
      times_classificados = jogos_oitavas.map { |j| j.vencedor(penaltis: true) }
      (0..7).step(2).map do |i|
        Jogo.new(times_classificados.at(i), times_classificados.at(i+1))
      end
    end
  end

  def jogos_semifinal
    @jogos_semifinal ||= begin
      times_classificados = jogos_quartas.map { |j| j.vencedor(penaltis: true) }
      (0..3).step(2).map do |i|
        Jogo.new(times_classificados.at(i), times_classificados.at(i+1))
      end
    end
  end

  def jogo_final
    @jogo_final ||= begin
      times_classificados = jogos_semifinal.map { |j| j.vencedor(penaltis: true) }
      Jogo.new(times_classificados.first, times_classificados.last)
    end
  end

  private

  def ordem_cruzamento_grupos
    # Primeiro os pares, depois os impares
    (0...@grupos.size).step(2).to_a + (1..@grupos.size).step(2).to_a
  end
end
