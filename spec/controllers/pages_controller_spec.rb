require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end

    it "should have the correct title" do
      get :home
      response.should have_selector(:title, :content => "IMP Reimbursements")
    end

    context 'when not signed in' do
      it "displays the sign in link" do
        get :home
        response.should have_selector('a', :content => "Sign In")
      end
    end

    context 'when signed in' do
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end

      it "displays the sign out link" do
        get :home
        response.should have_selector(:a, :content => "Sign Out")
      end
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end

    it "should have the correct title" do
      get :about
      response.should have_selector(:title, :content => "IMP Reimbursements | About")
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end

    it "should have the correct title" do
      get :contact
      response.should have_selector(:title, :content => "IMP Reimbursements | Contact")
    end
  end
end