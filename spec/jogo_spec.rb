require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'jogo'))

describe Jogo do
  before do
    @jogo = Jogo.new(Selecao.new("Brasil"), Selecao.new("Croácia"))
  end

  describe "#placar" do
    it "deveria exibir o placar do jogo" do
      expect(@jogo.placar).to eql "Brasil 0 x 0 Croácia"
    end

    context "ao atualizar o placar" do
      before do
        @jogo.instance_variable_set(:@gols_time1, 3)
        @jogo.instance_variable_set(:@gols_time2, 1)
      end

      it "deveria exibir o placar atualizado" do
        expect(@jogo.placar).to eql "Brasil 3 x 1 Croácia"
      end
    end
  end

  describe "#atualizar_placar!" do
    it "deveria atualizar o placar do jogo" do
      expect(@jogo.placar).to eql "Brasil 0 x 0 Croácia"

      @jogo.atualizar_placar!(3, 1)

      expect(@jogo.placar).to eql "Brasil 3 x 1 Croácia"
    end

    it "deveria atualizar o número de gols pró e contra de cada time" do
      expect(@jogo.time1.gols_pro).to eql 0
      expect(@jogo.time1.gols_contra).to eql 0
      expect(@jogo.time2.gols_pro).to eql 0
      expect(@jogo.time2.gols_contra).to eql 0

      @jogo.atualizar_placar!(4, 2)

      expect(@jogo.time1.gols_pro).to eql 4
      expect(@jogo.time1.gols_contra).to eql 2
      expect(@jogo.time2.gols_pro).to eql 2
      expect(@jogo.time2.gols_contra).to eql 4
    end
  end
end
