class ChangeWordToLettersInWords < ActiveRecord::Migration
  def change
    rename_column :words, :word, :letters
  end
end
