require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'jogo'))

describe Jogo do
  before do
    @jogo = Jogo.new(Selecao.new("Brasil"), Selecao.new("Croácia"), args)
  end

  let(:args) { {} }

  describe "#placar" do
    it "deveria exibir o placar do jogo" do
      expect(@jogo.placar).to eql "Brasil 0 x 0 Croácia"
    end

    context "ao atualizar o placar" do
      before do
        @jogo.atualizar_placar!(3, 1)
      end

      it "deveria exibir o placar atualizado" do
        expect(@jogo.placar).to eql "Brasil 3 x 1 Croácia"
      end
    end

    context "quando há disputa de pênaltis" do
      let(:args) { { penaltis: true } }

      before do
        @jogo.atualizar_placar!(1, 1)
        @jogo.atualizar_penaltis!(4, 2)
      end

      it "deveria exibir o placar com pênaltis" do
        expect(@jogo.placar).to eql "Brasil 1 (4) x (2) 1 Croácia"
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

  describe "#vencedor" do
    context "quando o time 1 fez mais gols" do
      before do
        @jogo.atualizar_placar!(2, 1)
      end

      it "deveria retornar o time 1" do
        expect(@jogo.vencedor).to eql @jogo.time1
      end
    end

    context "quando o time 2 fez mais gols" do
      before do
        @jogo.atualizar_placar!(2, 3)
      end

      it "deveria retornar o time 2" do
        expect(@jogo.vencedor).to eql @jogo.time2
      end
    end

    context "quando ocorre um empate" do
      before do
        @jogo.atualizar_placar!(1, 1)
      end

      context "e o jogo não tem disputa de pênaltis" do
        it "deveria retornar nil" do
          expect(@jogo.vencedor).to eql nil
        end
      end

      context "e o jogo tem disputa de pênaltis" do
        before do
          @jogo.atualizar_penaltis!(5, 4)
        end

        let(:args) { { penaltis: true } }

        it "deveria retornar o time que venceu a disputa de pênaltis" do
          expect(@jogo.vencedor).to eql @jogo.time1
        end
      end
    end
  end

  describe "#empate?" do
    context "quando os times fizeram o mesmo número de gols" do
      before do
        @jogo.atualizar_placar!(1, 1)
      end

      it "deveria retornar true" do
        expect(@jogo.empate?).to eql true
      end
    end

    context "quando os times não fizeram o mesmo número de gols" do
      before do
        @jogo.atualizar_placar!(2, 1)
      end

      it "deveria retornar false" do
        expect(@jogo.empate?).to eql false
      end
    end
  end
end
