require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'copa'))

describe Copa do
  before do
    @grupo_a = Grupo.new("grupo" => "A", "times" => %w{Brasil Croácia México Camarões})
    @grupo_b = Grupo.new("grupo" => "B", "times" => %w{Holanda Espanha Chile Austrália})
    @grupos = [@grupo_a, @grupo_b]
    @copa = Copa.new(@grupos)
  end

  describe "#jogos" do
    it "deveria retornar todos os jogos" do
      jogos = @grupo_a.jogos + @grupo_b.jogos
      expect(@copa.jogos).to eql jogos
    end
  end
end
