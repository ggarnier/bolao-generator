require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'jogo'))

describe Jogo do
  before do
    @jogo = Jogo.new("Brasil", "Croácia")
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

  describe "#atualizar_placar" do
    it "deveria atualizar o placar do jogo" do
      expect(@jogo.placar).to eql "Brasil 0 x 0 Croácia"

      @jogo.atualizar_placar(3, 1)

      expect(@jogo.placar).to eql "Brasil 3 x 1 Croácia"
    end
  end
end
