class Site::SearchController < SiteController
  def index
    @questions = Question.search(params[:term], params[:page])
  end
end
