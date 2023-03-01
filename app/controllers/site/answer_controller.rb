class Site::AnswerController < SiteController
  def question_response
    @answer = Answer.find(params[:answer_id])
  end
end
