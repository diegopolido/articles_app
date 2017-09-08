require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without title and description" do
    article = Article.new
    assert_not article.valid?
    assert_equal [:title, :description], article.errors.keys
  end
end
