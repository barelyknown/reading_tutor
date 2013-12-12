class Word < ActiveRecord::Base

  has_many :syllables
  has_many :audios, class_name: "WordAudio"
  has_many :definitions

  def self.random(n=2, min_corpus_count=100000)
    Wordnik.word.get_random_words(limit: n, min_corpus_count: min_corpus_count).collect do |w|
      new(letters: w["word"])
    end
  end

  def to_param
    letters
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
