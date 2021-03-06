require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'bolao'))

describe Bolao do
  before do
    @grupo_a = Grupo.new("grupo" => "A", "times" => %w{Brasil Croácia México Camarões})
    @grupo_b = Grupo.new("grupo" => "B", "times" => %w{Holanda Espanha Chile Austrália})
    @grupos = [@grupo_a, @grupo_b]
    @copa = Copa.new(@grupos)
    @bolao = Bolao.new(@copa)
  end

  describe "#chutar_resultados!" do
    it "deveria gerar chutes para todas as fases da copa" do
      expect(@bolao).to receive(:chutar_primeira_fase!)
      expect(@bolao).to receive(:chutar_oitavas!)
      expect(@bolao).to receive(:chutar_quartas!)
      expect(@bolao).to receive(:chutar_semifinal!)
      expect(@bolao).to receive(:chutar_terceiro_lugar!)
      expect(@bolao).to receive(:chutar_final!)

      @bolao.chutar_resultados!
    end
  end

  describe "#chutar_primeira_fase!" do
    it "deveria gerar chutes para todos os jogos da primeira fase" do
      jogos = @grupos.map(&:jogos).flatten
      expect(@copa).
        to receive(:jogos_primeira_fase).
        and_return(jogos)
      jogos.each do |jogo|
        expect(@bolao).to receive(:chutar_jogo).with(jogo)
      end

      @bolao.chutar_primeira_fase!
    end

    it "deveria atualizar a classificação da primeira fase" do
      expect(@copa).to receive(:atualizar_classificacao_primeira_fase!)

      @bolao.chutar_primeira_fase!
    end
  end

  describe "#chutar_oitavas!" do
    it "deveria gerar chutes para todos os jogos das oitavas de final" do
      jogos = @copa.jogos_oitavas
      jogos.each do |jogo|
        expect(@bolao).to receive(:chutar_jogo)
      end

      @bolao.chutar_oitavas!
    end
  end

  describe "#chutar_quartas!" do
    it "deveria gerar chutes para todos os jogos das quartas de final" do
      jogos = @copa.jogos_quartas
      jogos.each do |jogo|
        expect(@bolao).to receive(:chutar_jogo)
      end

      @bolao.chutar_quartas!
    end
  end

  describe "#chutar_semifinal!" do
    it "deveria gerar chutes para todos os jogos das semifinais" do
      jogos = @copa.jogos_semifinal
      jogos.each do |jogo|
        expect(@bolao).to receive(:chutar_jogo)
      end

      @bolao.chutar_semifinal!
    end
  end

  describe "#chutar_terceiro_lugar!" do
    it "deveria gerar chute para a decisão do terceiro lugar" do
      jogo = @copa.jogo_terceiro_lugar
      expect(@bolao).to receive(:chutar_jogo)

      @bolao.chutar_terceiro_lugar!
    end
  end

  describe "#chutar_final!" do
    it "deveria gerar chute para a final" do
      jogo = @copa.jogo_final
      expect(@bolao).to receive(:chutar_jogo)

      @bolao.chutar_final!
    end
  end

  describe "#chutar_jogo" do
    let(:jogo) { @grupo_a.jogos.first }

    it "deveria atualizar o placar do jogo com valores aleatórios" do
      expect(jogo).
        to receive(:atualizar_placar!).
        with(kind_of(Numeric), kind_of(Numeric))

      @bolao.chutar_jogo(jogo)
    end

    context "quando o chute resulta em empate" do
      before do
        allow(jogo).to receive(:empate?).and_return(true)
      end

      context "e o jogo permite decisão por pênaltis" do
        let(:jogo) { Jogo.new(@grupo_a.times.at(0), @grupo_a.times.at(1), penaltis: true) }

        it "deveria chutar o resultado da disputa de pênaltis" do
          expect(@bolao).
            to receive(:chutar_disputa_penaltis)

          @bolao.chutar_jogo(jogo)
        end
      end

      context "e o jogo não permite decisão por pênaltis" do
        it "não deveria chutar o resultado da disputa de pênaltis" do
          expect(@bolao).
            not_to receive(:chutar_disputa_penaltis)

          @bolao.chutar_jogo(jogo)
        end
      end
    end
  end

  describe "#chutar_disputa_penaltis" do
    let(:jogo) { @grupo_a.jogos.first }

    it "deveria chutar o resultado da disputa de pênaltis" do
      expect(jogo).
        to receive(:atualizar_penaltis!).
        with(kind_of(Numeric), kind_of(Numeric))

      @bolao.chutar_disputa_penaltis(jogo)
    end
  end
end
