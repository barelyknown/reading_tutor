class Definition < ActiveRecord::Base

  def self.new_from_wordnik(d)
    new(text: d["text"], source: d["sourceDictionary"])
  end

end
