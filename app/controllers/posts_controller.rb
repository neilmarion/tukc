class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:index]
  
  def index
    @recruits = current_user.recruits.order('created_at DESC')
  end

  def home

  end
end
