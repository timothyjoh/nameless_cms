class CreateElements < ActiveRecord::Migration
  def self.up
    create_table :elements do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.string :search_terms
      t.integer :user_id
      t.integer :page_id
      t.integer :position
      t.string :type
      t.datetime :published_at
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end

  def self.down
    drop_table :elements
  end
end
