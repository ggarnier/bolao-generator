require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'processador'))

describe Processador do
  let :path_arquivo do
    "./spec/fixtures/arquivo.json"
  end

  before do
    @processador = Processador.new(path_arquivo)
  end

  describe "#gerar_grupos" do
    it "deveria gerar os grupos a partir do arquivo" do
      grupos = @processador.gerar_grupos

      expect(grupos.size).to eql 2
      grupos.each do |grupo|
        expect(grupo).to be_kind_of Grupo
      end
    end

    context "quando o arquivo não existe" do
      let :path_arquivo do
        "./spec/fixtures/nao_existe.json"
      end

      it "deveria lançar ArgumentError" do
        expect { @processador.gerar_grupos }.to raise_error ArgumentError
      end
    end

    context "quando o arquivo não é um JSON válido" do
      let :path_arquivo do
        "./spec/fixtures/invalido.json"
      end

      it "deveria lançar ArgumentError" do
        expect { @processador.gerar_grupos }.to raise_error ArgumentError
      end
    end
  end
end
