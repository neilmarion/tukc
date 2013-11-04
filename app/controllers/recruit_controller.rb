class RecruitController < ApplicationController
  layout 'invite'
  def invite
    @inviter = User.find(params[:id])
  end
end
