module SiteHelper
  def jumbotron_message
    case params[:action]
    when 'index'
      'Últimas perguntas cadastradas'
    when 'questions'
      "Exibindo resultados para o termo \"#{params[:term]}\""
    when 'subject'
      "Exibindo questões de assunto: \"#{params[:subject]}\""
    end
  end
end
