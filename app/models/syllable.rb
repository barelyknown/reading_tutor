class Syllable < ActiveRecord::Base

  def self.new_from_wordnik(s)
    new(sequence: s["seq"], letters: s["text"], stress: ["type"])
  end

end
