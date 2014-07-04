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

  describe "#chutar!" do
    it "deveria gerar chutes para todos os jogos dos grupos" do
      @grupos.map(&:jogos).flatten.each do |jogo|
        expect(jogo).to receive(:atualizar_placar)
      end

      @bolao.chutar!
    end
  end
end
