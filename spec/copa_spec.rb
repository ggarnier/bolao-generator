require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'copa'))

describe Copa do
  before do
    @grupo_a = Grupo.new("grupo" => "A", "times" => %w{Brasil Croácia México Camarões})
    @grupo_b = Grupo.new("grupo" => "B", "times" => %w{Holanda Espanha Chile Austrália})
    @grupo_c = Grupo.new("grupo" => "C", "times" => ["Colômbia", "Grécia", "Costa do Marfim", "Japão"])
    @grupo_d = Grupo.new("grupo" => "D", "times" => ["Uruguai", "Costa Rica", "Inglaterra", "Itália"])
    @grupos = [@grupo_a, @grupo_b, @grupo_c, @grupo_d]
    @copa = Copa.new(@grupos)
  end

  describe "#jogos_primeira_fase" do
    it "deveria retornar todos os jogos da primeira fase" do
      jogos = @grupo_a.jogos + @grupo_b.jogos + @grupo_c.jogos + @grupo_d.jogos
      expect(@copa.jogos_primeira_fase).to eql jogos
    end
  end

  describe "#atualizar_classificacao_primeira_fase!" do
    it "deveria atualizar a classificação de todos os grupos" do
      @copa.grupos.each do |grupo|
        expect(grupo).to receive(:atualizar_classificacao!)
      end

      @copa.atualizar_classificacao_primeira_fase!
    end
  end

  describe "#jogos_oitavas" do
    it "deveria retornar os cruzamentos dos classificados da primeira fase" do
      allow(@copa.grupos.first).
        to receive(:classificados).
        and_return(["Brasil", "México"])

      allow(@copa.grupos.at(1)).
        to receive(:classificados).
        and_return(["Holanda", "Chile"])

      allow(@copa.grupos.at(2)).
        to receive(:classificados).
        and_return(["Colômbia", "Grécia"])

      allow(@copa.grupos.at(3)).
        to receive(:classificados).
        and_return(["Costa Rica", "Uruguai"])

      jogos_oitavas = @copa.jogos_oitavas
      expect(jogos_oitavas.size).to eql @copa.grupos.size

      jogo1 = jogos_oitavas.first
      expect(jogo1.time1).to eql "Brasil"
      expect(jogo1.time2).to eql "Chile"

      jogo2 = jogos_oitavas.at(1)
      expect(jogo2.time1).to eql "Colômbia"
      expect(jogo2.time2).to eql "Uruguai"

      jogo3 = jogos_oitavas.at(2)
      expect(jogo3.time1).to eql "Holanda"
      expect(jogo3.time2).to eql "México"

      jogo4 = jogos_oitavas.at(3)
      expect(jogo4.time1).to eql "Costa Rica"
      expect(jogo4.time2).to eql "Grécia"
    end
  end

  describe "#jogos_quartas" do
    it "deveria retornar os cruzamentos dos classificados das oitavas de final" do
      allow(@copa).
        to receive(:jogos_oitavas).
        and_return(
          8.times.map do |i|
            time1 = Selecao.new("time #{i+1}")
            time2 = Selecao.new("time #{i+9}")
            jogo = Jogo.new(time1, time2, penaltis: true)
            allow(jogo).to receive(:vencedor).and_return(time1)
            jogo
          end
        )

      jogos_quartas = @copa.jogos_quartas

      expect(jogos_quartas.size).to eql 4
      jogos_quartas.each_with_index do |jogo, i|
        expect(jogo.time1.nome).to eql "time #{2*i+1}"
        expect(jogo.time2.nome).to eql "time #{2*i+2}"
      end
    end
  end

  describe "#jogos_semifinal" do
    it "deveria retornar os cruzamentos dos classificados das quartas de final" do
      allow(@copa).
        to receive(:jogos_quartas).
        and_return(
          4.times.map do |i|
            time1 = Selecao.new("time #{i+1}")
            time2 = Selecao.new("time #{i+5}")
            jogo = Jogo.new(time1, time2, penaltis: true)
            allow(jogo).to receive(:vencedor).and_return(time1)
            jogo
          end
        )

      jogos_semifinal = @copa.jogos_semifinal

      expect(jogos_semifinal.size).to eql 2
      jogos_semifinal.each_with_index do |jogo, i|
        expect(jogo.time1.nome).to eql "time #{2*i+1}"
        expect(jogo.time2.nome).to eql "time #{2*i+2}"
      end
    end
  end

  describe "#jogo_terceiro_lugar" do
    it "deveria retornar os classificados da decisão do terceiro lugar" do
      allow(@copa).
        to receive(:jogos_semifinal).
        and_return(
          2.times.map do |i|
            time1 = Selecao.new("time #{i+1}")
            time2 = Selecao.new("time #{i+3}")
            jogo = Jogo.new(time1, time2, penaltis: true)
            allow(jogo).to receive(:vencedor).and_return(time1)
            jogo
          end
        )

      jogo = @copa.jogo_terceiro_lugar
      expect(jogo.time1.nome).to eql "time 3"
      expect(jogo.time2.nome).to eql "time 4"
    end
  end

  describe "#jogo_final" do
    it "deveria retornar os classificados da final" do
      allow(@copa).
        to receive(:jogos_semifinal).
        and_return(
          2.times.map do |i|
            time1 = Selecao.new("time #{i+1}")
            time2 = Selecao.new("time #{i+3}")
            jogo = Jogo.new(time1, time2, penaltis: true)
            allow(jogo).to receive(:vencedor).and_return(time1)
            jogo
          end
        )

      final = @copa.jogo_final
      expect(final.time1.nome).to eql "time 1"
      expect(final.time2.nome).to eql "time 2"
    end
  end

  describe "#campeao" do
    it "deveria exibir o vencedor da final" do
      final = Jogo.new(Selecao.new("time 1"), Selecao.new("time 2"), penaltis: true)
      expect(@copa).
        to receive(:jogo_final).
        and_return(final)
      expect(final).
        to receive(:vencedor).
        and_return(final.time2)

      expect(@copa.campeao.nome).to eql "time 2"
    end
  end
end
