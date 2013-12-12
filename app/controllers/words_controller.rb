class WordsController < ApplicationController

  def new
    @word = Word.random(1).first
    redirect_to word_path(@word)
  end

  def create
    redirect_to word_path(id: params[:word][:letters])
  end

  def show
    @word = Word.new(letters: params[:id])
  end

end
