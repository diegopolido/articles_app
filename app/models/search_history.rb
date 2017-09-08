class SearchHistory < ApplicationRecord
  scope :count_by_relevants, -> { where("result_size > 0").order(:relevant_term).group(:relevant_term).count.sort_by{ |k, v| v }.reverse.to_h }
  scope :count_by_relevants_with_no_results, -> { where("result_size = 0").order(:relevant_term).group(:relevant_term).count.sort_by{ |k, v| v }.reverse.to_h }
  def self.create_and_update_relevants(term, ip_address, articles)
    ids = articles.map(&:id).sort
    result_hash = ids.hash.to_s
    term_to_save = term

    #if we have the same results for the equivalent term, we should take the biggest relevant term
    similar_search_histories_by_term = SearchHistory.where("term like ?", "#{term}%")
    similar_search_histories_by_term.each do |previous_search_history|
      term_to_save = previous_search_history.term if previous_search_history.term.size > term_to_save.size && previous_search_history.result_hash == result_hash
    end

    #if we have same results for a bigger term, we should update their relevant terms
    similar_search_histories_by_result_hash = SearchHistory.where("result_hash = ?", result_hash)
    similar_search_histories_by_result_hash.each do |previous_search_history|
      if previous_search_history.relevant_term.size < term.size && term.include?(previous_search_history.relevant_term)
        previous_search_history.relevant_term = term
        previous_search_history.save
      end
    end

    SearchHistory.create(term: term, relevant_term: term_to_save, ip_address: ip_address, result_size: articles.size, result_hash: result_hash)
  end
end
