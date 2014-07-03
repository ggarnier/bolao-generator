require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'grupo'))

describe Grupo do
  before do
    @grupo = Grupo.new("grupo" => "A", "times" => %w{Brasil Croácia México Camarões})
  end

  describe "#jogos" do
    it "deveria exibir os jogos do grupo" do
      jogos = @grupo.jogos

      expect(jogos.size).to eql 6
      expect(jogos.first).to eql "Brasil x Croácia"
    end
  end
end
