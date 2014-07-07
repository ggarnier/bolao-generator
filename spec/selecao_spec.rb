require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'selecao'))

describe Selecao do
  before do
    @selecao = Selecao.new("Brasil")
  end

  describe "#saldo" do
    it "deveria calcular o saldo de gols" do
      @selecao.gols_pro = 7
      @selecao.gols_contra = 2

      expect(@selecao.saldo).to eql 5

      @selecao.gols_contra = 8
      expect(@selecao.saldo).to eql -1
    end
  end
end
