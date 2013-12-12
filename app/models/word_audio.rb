class WordAudio < ActiveRecord::Base

  def self.new_from_wordnik(a)
    new(seconds: a["duration"], file_url: a["fileUrl"], attribution: a["attributionText"])
  end

end
