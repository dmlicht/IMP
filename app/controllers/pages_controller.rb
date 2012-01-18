class PagesController < ApplicationController
  def home
  	if signed_in?
  		@reimbursement = current_user.reimbursements.build
  		@reimbursements = current_user.reimbursements
  	else
  	end
  end

  def about
    @sub_title = "About"
  end

  def contact
    @sub_title = "Contact"
  end
end