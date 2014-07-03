require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'bolao'))

describe Bolao do
  before do
    @grupo = Grupo.new("grupo" => "A", "times" => %w{Brasil Croácia México Camarões})
    @bolao = Bolao.new(@grupo)
  end

  describe "#chutar" do
    it "deveria gerar chutes para todos os jogos dos grupos" do
      @grupo.jogos.each do |jogo|
        expect(jogo).to receive(:atualizar_placar)
      end

      @bolao.chutar
    end
  end
end
