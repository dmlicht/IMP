require 'spec_helper'

describe SessionsController do
	render_views
	
	before(:each) do
		request.env['HTTPS'] = 'on'
	end

	describe '#create' do
		context 'given pre-existing auth and provider combination' do
			before(:each) do
				@user = Factory(:user)
				request.env['omniauth.auth'] = {
					:uid => @user.uid,
					:provider => @user.provider,
					:info => {
						:first_name => @user.first_name,
						:last_name => @user.last_name,
						:email => "#{@user.first_name}.#{@user.last_name}@incentivementoringprogram.org"
					}
				}
			end

			it 'signs the user in' do
				post :create
				controller.should be_signed_in
				controller.current_user == @user
			end

			it 'redirects to root path' do
				post :create
				response.should redirect_to(root_path)
			end

			it 'flashes a success message' do
				flash.should_not be_nil
			end
		end

		context 'given non-pre-existing auth and provider combination' do
			before(:each) do
				request.env['omniauth.auth'] = {
					:uid => '012357589',
					:provider => 'google_oauth2',
					:info => {
						:first_name => 'firsty',
						:last_name => 'lasty',
						:email => "#{:first_name}.#{:last_name}@iivementoringprogram.org"
					}
				}
			end

			context 'with incorrect email format' do
				it 'does not create a new user' do
					expect {
						post :create
					}.not_to change(User, :count)
				end

				it 'does not log a user in' do
					post :create
					controller.should_not be_signed_in
				end

				it 'redirects to root path' do
					post :create
					response.should redirect_to(root_path)
				end
			end

			context 'with valid credentials' do
				before(:each) do
					request.env['omniauth.auth'][:info][:email] = "first_name.last_name@incentivementoringprogram.org"
				end

				it 'creates a new user' do
					expect {
						post :create
					}.to change(User, :count).by(1)
				end

				it 'signs the user in' do
					post :create
					controller.should be_signed_in
					controller.current_user.first_name.should == request.env['omniauth.auth'][:info][:first_name]
				end

				it 'flashes a success message' do
					post :create
					flash.should_not be_nil
				end

				it 'redirects to the root path' do
					post :create
					response.should redirect_to(root_path)
				end
			end
		end
	end

	describe '#destroy' do
		context 'when not signed in' do
			it 'redirects to homepage' do
				delete :destroy
				response.should redirect_to(root_path)
			end

			it 'flashes a notice' do
				delete :destroy
				flash.should_not be_nil
			end
		end

		context 'when signed in' do
			before(:each) do
				user = Factory(:user)
				test_sign_in(user)
			end

			it 'signs you out' do
				delete :destroy
				controller.should_not be_signed_in
			end

			it 'flashes a success message' do
				delete :destroy
				flash[:success] =~ /signed out/i
			end

			it 'redirects to the root path' do
				delete :destroy
				response.should redirect_to(root_path)
			end
		end
	end
end
