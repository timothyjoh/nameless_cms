class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.string :meta_keywords
      t.string :meta_description
      t.integer :parent_id, :null => false ,:default => 0
      t.integer :lft
      t.integer :rgt
      t.integer :position
      t.string :type
      t.string :template
      t.datetime :published_at

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
