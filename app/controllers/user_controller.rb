require 'parse_config'

class UserController < ApplicationController
	def login
	end

	def create
  	begin
			signup = Parse::User.new({
			  :username => user_signup_params['user'],
			  :email => user_signup_params['email'],
			  :password => user_signup_params['password'],
			})
			response = signup.save
			cookies.signed[:cashOnlyUser] = { value: response["objectId"], expires: (Time.now.getgm + 86400) }
			redirect_to '/account'	
		rescue Parse::ParseProtocolError => e
			if e.to_s.split(":").first == '202'
		  	flash[:error] = "Username is taken"
		  elsif e.to_s.split(":").first == "203"
		  	flash[:error] = "Email is taken"
		  end
		  redirect_to '/signup'
		end
	end

	def auth
	  begin
			login = Parse::User.authenticate(user_login_params['username'],user_login_params['pass'])
	    cookies.signed[:cashOnlyUser] = { value: login["objectId"], expires: (Time.now.getgm + 86400) }	
	    redirect_to '/account'
		rescue Parse::ParseProtocolError => e
			if e.to_s.split(":").first == '101'
			  flash[:error] = "Username or password is incorrect"
			  redirect_to '/login'
			end
		end

	end

	private

  def user_login_params
    params.permit(:username, :pass)
  end

end
