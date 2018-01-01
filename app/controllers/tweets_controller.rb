class TweetsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
#    @tweets = Tweet.all.order("id DESC").page(params[:page]).per(5)
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("id DESC")
  end

  def new
  end

  def create
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id:current_user.id)
    #binding.pry
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(tweet_params)
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def show
    @tweet  = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
  end

  private
  def tweet_params
    params.permit(:image, :text)
    #binding.pry
  end

  private
  def move_to_index
    redirect_to action: :index unless user_signed_in?
    # indexアクションを強制的に実行する
  end


#メソッドの返り値はそのメソッドの中で最後に実行されている式の値

end
