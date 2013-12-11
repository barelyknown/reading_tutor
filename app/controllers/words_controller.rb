class WordsController < ApplicationController

  def new
    @word = Word.new
  end

  def create
    redirect_to word_path(id: params[:word][:word])
  end

  def show
    @word = Word.new(word: params[:id])
  end

end
