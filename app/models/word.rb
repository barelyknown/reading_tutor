class Word < ActiveRecord::Base

  has_many :syllables
  has_many :audios, class_name: "WordAudio"
  has_many :definitions

  cattr_accessor :all_by_frequency

  def self.all_by_frequency
    @all_by_frequency ||= Array.new.tap do |words|
      CSV.foreach(Rails.root.join("db","seed","words.csv")) { |row| words << row[0] }
    end
  end

  def self.find_by_frequency(frequency)
    new letters: all_by_frequency[Integer(frequency) - 1]
  end

  def self.random(n=2, min_corpus_count=100000)
    2.times.collect { all_by_frequency.sample }.collect { |w| new(letters: w) }
  end

  def frequency
    self.class.all_by_frequency.index(letters) + 1
  end

  def to_param
    frequency.to_s
  end

  def syllables
    super.any? ? super : build_syllables
  end

  def definitions
    super.any? ? super : build_definitions
  end

  def audios
    super.any? ? super : build_audios
  end

private

  def canonical_form
    @canonical_form ||= Wordnik.word.get_word(letters).try(:[], "canonicalForm")
  end

  def build_syllables
    wordnik_syllables = Wordnik.word.get_hyphenation(canonical_form || letters)
    case wordnik_syllables.size
      when 0 then [Syllable.new(sequence: 0, letters: letters, stress: "stress")]
      else wordnik_syllables.collect { |syllable| Syllable.new_from_wordnik(syllable) }
    end
  end

  def build_audios
    Wordnik.word.get_audio(letters, use_canonical: false).collect do |audio|
      WordAudio.new_from_wordnik(audio)
    end
  end

  def build_definitions
    Wordnik.word.get_definitions(letters, source_dictionaries: "wiktionary").collect do |definition|
      Definition.new_from_wordnik(definition)
    end
  end

end
