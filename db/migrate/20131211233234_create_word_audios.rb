class CreateWordAudios < ActiveRecord::Migration
  def change
    create_table :word_audios do |t|
      t.integer :word_id
      t.decimal :minutes
      t.string :file_url

      t.timestamps
    end
  end
end
