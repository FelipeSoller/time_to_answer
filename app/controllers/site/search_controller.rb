class Site::SearchController < SiteController
  def index
    @questions = Question._search(params[:term], params[:page])
  end
end
