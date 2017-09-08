class HomeController < ApplicationController
  def index
  end

  def search
    @term = params[:term].strip
    @articles = Article.search_for(@term)
    SearchHistory.create_and_update_relevants(@term, params[:ip_address], @articles)
    respond_to do |format|
      format.json { render json: @articles }
    end
  end
end
