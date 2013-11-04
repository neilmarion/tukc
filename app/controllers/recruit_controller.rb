class RecruitController < ApplicationController
  layout 'invite', only: [:invite]
  before_filter :authenticate_user!, only: [:index]

  def invite
    @inviter = User.find(params[:id])
  end

  def index

  end
end
