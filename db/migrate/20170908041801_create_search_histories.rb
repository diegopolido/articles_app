class CreateSearchHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :search_histories do |t|
      t.string :term
      t.string :ip_address
      t.integer :result_size

      t.timestamps
    end
  end
end
