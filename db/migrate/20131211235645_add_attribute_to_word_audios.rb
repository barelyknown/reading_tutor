class AddAttributeToWordAudios < ActiveRecord::Migration
  def change
    add_column :word_audios, :attribution, :string
  end
end
