class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :meta_keywords
      t.string :meta_description
      t.integer :parent_id
      t.integer :position
      t.string :type
      t.string :template

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
