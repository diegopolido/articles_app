class AddResultHashToSearchHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :search_histories, :relevant_term, :string
    add_column :search_histories, :result_hash, :string
  end
end
