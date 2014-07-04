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
      expect(grupos.at(0).nome).to eql "A"
      expect(grupos.at(1).nome).to eql "B"
    end

    it "deveria gerar os times dos grupos" do
      grupos = @processador.gerar_grupos

      expect(grupos.at(0).times.map(&:nome)).to eql ["Brasil", "Croácia", "México", "Camarões"]
      expect(grupos.at(1).times.map(&:nome)).to eql ["Holanda", "Espanha", "Chile", "Austrália"]
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
