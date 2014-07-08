require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'grupo'))

describe Grupo do
  before do
    @grupo = Grupo.new("grupo" => "A", "times" => %w{Brasil Croácia México Camarões})
  end

  let :atualizar_resultados_grupo do
    @grupo.jogos.at(0).atualizar_placar!(3, 1)
    @grupo.jogos.at(1).atualizar_placar!(0, 0)
    @grupo.jogos.at(2).atualizar_placar!(4, 1)
    @grupo.jogos.at(3).atualizar_placar!(1, 3)
    @grupo.jogos.at(4).atualizar_placar!(4, 0)
    @grupo.jogos.at(5).atualizar_placar!(1, 0)
  end

  it "deveria instanciar os times" do
    expect(@grupo.times.size).to eql 4
    @grupo.times.each do |time|
      expect(time).to be_kind_of Selecao
    end
  end

  describe "#jogos" do
    it "deveria exibir os jogos do grupo" do
      jogos = @grupo.jogos

      expect(jogos.size).to eql 6
      jogos.each do |jogo|
        expect(jogo).to be_kind_of Jogo
      end
      expect(jogos.first.placar).to eql "Brasil 0 x 0 Croácia"
    end
  end

  describe "#atualizar_classificacao!" do
    before do
      atualizar_resultados_grupo

      @grupo.atualizar_classificacao!
    end

    it "deveria atualizar o número de pontos de cada time do grupo" do
      expect(@grupo.times.map(&:pontos)).to eql [7, 7, 3, 0]
    end

    it "deveria reordenar os times de acordo com a classificação" do
      expect(@grupo.times.map(&:nome)).to eql %w{Brasil México Croácia Camarões}
    end
  end

  describe "#classificados" do
    before do
      atualizar_resultados_grupo
    end

    it "deveria retornar os times classificados" do
      expect(@grupo.classificados).to eql [@grupo.times.at(0), @grupo.times.at(1)]
    end
  end
end
