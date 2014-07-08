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

  describe "#chutar_primeira_fase!" do
    it "deveria gerar chutes para todos os jogos da primeira fase" do
      @grupos.map(&:jogos).flatten.each do |jogo|
        expect(jogo).to receive(:atualizar_placar!)
      end

      @bolao.chutar_primeira_fase!
    end

    it "deveria atualizar a classificação de todos os grupos" do
      @grupos.each do |grupo|
        expect(grupo).to receive(:atualizar_classificacao!)
      end

      @bolao.chutar_primeira_fase!
    end
  end

  describe "#chutar_oitavas!" do
    it "deveria gerar chutes para todos os jogos das oitavas de final" do
      jogos = @copa.jogos_oitavas
      jogos.each { |j| expect(j).to receive(:atualizar_placar!) }

      @bolao.chutar_oitavas!
    end
  end
end
