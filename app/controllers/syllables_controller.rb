class SyllablesController < ApplicationController

  def index
    @word = Word.find_by_frequency(params[:word_id])
    @syllables = @word.syllables
    respond_to do |format|
      format.js {render partial: "syllables/index", locals: { syllables: @syllables } }
    end
  end

end