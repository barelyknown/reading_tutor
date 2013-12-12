class WordsController < ApplicationController

  def index
    redirect_to word_path(id: 1)
  end

  def new
    @word = Word.random(1).first
    render :show
  end

  def create
    redirect_to word_path(id: params[:word][:letters])
  end

  def show
    id = params[:id].to_i == 0 ? Word.all_by_frequency.index(params[:id]) : params[:id].to_i - 1
    @word = Word.new(letters: Word.all_by_frequency[id])
  end

end
