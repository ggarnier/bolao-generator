require 'json'
require File.expand_path(File.join(File.dirname(__FILE__), 'grupo'))

class Processador
  def initialize(arquivo)
    @arquivo = arquivo
  end

  def gerar_grupos
    processar_arquivo

    @dados.map {|item| Grupo.new(item) }
  end

  private
  def processar_arquivo
    @dados = JSON.parse(File.read(@arquivo))
  rescue Errno::ENOENT, JSON::ParserError
    raise ArgumentError.new("erro ao processar o arquivo #{@arquivo}")
  end
end
