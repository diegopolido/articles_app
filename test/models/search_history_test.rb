require 'test_helper'

class SearchHistoryTest < ActiveSupport::TestCase
  test "should fetch a relevant term from histories when it has the same results" do
    search_histories = save_term_and_count("How do I")
    assert search_histories["How do I"], 1
    search_histories = save_term_and_count("How do")
    assert search_histories["How do I"], 2
  end

  test "should create a two records for existing article and update their relevant terms" do
    search_histories = save_term_and_count("How do I cancel")
    assert search_histories["How do I cancel"], 1
    search_histories = save_term_and_count("How do I cancel my subscription")
    assert search_histories["How do I cancel my subscription"], 2
  end

  test "should create two different count for existing article when the terms aren't relevant" do
    search_histories = save_term_and_count("cancel")
    search_histories = save_term_and_count("subscription")
    assert search_histories["cancel"], 1
    assert search_histories["subscription"], 1
  end

  test "should count twice when you search twice" do
    save_term_and_count("cancel")
    search_histories = save_term_and_count("cancel")
    assert search_histories["cancel"], 2
  end

  def save_term_and_count(term)
    articles = Article.search_for(term)
    SearchHistory.create_and_update_relevants(term, "localhost", articles)
    SearchHistory.count_by_relevants
  end
end
