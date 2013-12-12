class RenameMinutesToSecondsInWordAudios < ActiveRecord::Migration
  def change
    rename_column :word_audios, :minutes, :seconds
  end
end
