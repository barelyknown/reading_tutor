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
    id = params[:id].to_i
    if id == 0 # word id
      unless id = Word.all_by_frequency.index(params[:id])
        id = Word.all_by_frequency.index(params[:id].downcase)
      end
      id += 1
    end
    redirect_to request.referer, notice: "asdf" and return unless id
    @word = Word.find_by_frequency(id)
  end

  def random
    @word = Word.random
    render :show
  end

  def common
    @word = Word.common
    render :show
  end

  def uncommon
    @word = Word.uncommon
    render :show
  end

end
