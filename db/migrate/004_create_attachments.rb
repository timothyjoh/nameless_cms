class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.title :string
      t.type :string
      t.attachment_file_name :string
      t.attachment_content_type :string
      t.attachment_file_size :string

      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
