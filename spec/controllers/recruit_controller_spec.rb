require 'spec_helper'

describe RecruitController do

  describe "GET 'invite'" do
    it "returns http success" do
      get 'invite'
      response.should be_success
    end
  end

end
