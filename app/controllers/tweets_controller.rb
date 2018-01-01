class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.order("id DESC").page(params[:page]).per(5)
  end

  def new
  end

  def create
    Tweet.create(tweet_params)
    #binding.pry
  end

  private
  def tweet_params
    params.permit(:name, :image, :text)
    #binding.pry
  end
#メソッドの返り値はそのメソッドの中で最後に実行されている式の値

end
