class DashboardController < ApplicationController
  def index
    @search_histories = SearchHistory.count_by_relevants
    @search_histories_no_results = SearchHistory.count_by_relevants_with_no_results
    @search_histories_by_ip = SearchHistory.select(:ip_address, 'array_agg(relevant_term)').group(:ip_address).pluck(:ip_address, 'array_agg(relevant_term)')
  end

  def destroy_histories
    SearchHistory.destroy_all
    redirect_to dashboard_path, notice: "Search history was successfully cleared."
  end
end
