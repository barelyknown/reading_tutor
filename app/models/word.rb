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

  def self.random
    new letters: all_by_frequency.sample
  end

  def self.common
    new letters: all_by_frequency[0..1000].sample
  end

  def self.uncommon
    new letters: all_by_frequency[(all_by_frequency.size / 4)..(all_by_frequency.size - 1)].sample
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
    get_syllables.collect { |syllable| Syllable.new_from_wordnik(syllable) }
  end

  def get_syllables
    wordnik_syllables = Wordnik.word.get_hyphenation(letters)
    if wordnik_syllables.size <= 1
      hyphenator.visualize(letters).split("-").collect.with_index do |syllable, i|
        { "text" => syllable, "seq" => i, "stess" => "stress" }
      end
    else
      wordnik_syllables
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

  def hyphenator
    Text::Hyphen.new(language: "en_us", left: 1, right: 1 )
  end

end
