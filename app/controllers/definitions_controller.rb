class DefinitionsController < ApplicationController

  def index
    @word = Word.find_by_frequency(params[:word_id])
    @definitions = @word.definitions
    respond_to do |format|
      format.js {render partial: "definitions/index", locals: { definitions: @definitions } }
    end
  end
end
