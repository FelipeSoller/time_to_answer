class Site::AnswerController < SiteController
  def question_response
    @answer = Answer.find(params[:answer_id])
    UserStatistic.set_statistic(@answer, current_user)
  end
end
