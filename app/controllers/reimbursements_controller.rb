class ReimbursementsController < ApplicationController

	def show
		@reimbursement = Reimbursement.find(params[:id])
	end
	
  def create
  	@reimbursement = current_user.reimbursements.build(params[:reimbursement])
  	if @reimbursement.save
  		flash[:success] = "Reimbursement Submitted"
  		redirect_to root_path
  	else
  		flash.now[:error] = "Could Not Submit"
  		@reimbursements = current_user.reimbursements
  		render 'pages/home'
  	end
  end

  def update
  end

  def destroy
  end

end
