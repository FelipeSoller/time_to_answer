class Site::SearchController < SiteController
  def questions
    @questions = Question._search(params[:term], params[:page])
  end

  def subject
    @questions = Question._search_subject(params[:subject_id], params[:page])
  end
end
