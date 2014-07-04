require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'grupo'))

describe Grupo do
  before do
    @grupo = Grupo.new("grupo" => "A", "times" => %w{Brasil Croácia México Camarões})
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
end
