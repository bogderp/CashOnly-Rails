require 'parse_config'



class UserController < ApplicationController

	skip_before_filter  :verify_authenticity_token

	def login
    if cookies.signed[:cashOnlyUser]
      redirect_to '/account'
    end
	end

	def signup
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

	def venmo_auth
		if !params[:code].nil?

			uri = URI("https://api.venmo.com/v1/oauth/access_token")
			response = Net::HTTP.post_form(uri, 'client_id' => '2877', 'code' => params[:code], "client_secret" => "6zDZV5JFygYH2dQPjETAybvpaHj6eY7g").body
			data = JSON.parse(response)["user"]
			puts data

			session[:access_token] = JSON.parse(response)["access_token"]
			puts session[:access_token]
			session[:venmo_username] = data["username"]
			session[:venmo_id] = data["id"]
		end
		redirect_to "/need_cash"
	end

	def venmo
		amount = venmo_params['money']
		uri = URI("https://api.venmo.com/v1/payments")
		puts session[:access_token]
		puts "Amount: "
		puts amount
		@response = Net::HTTP.post_form(uri, 'user_id' => '1221360378445824920', 'amount' => amount.to_s, "note" => "Cash Only", "audience" => "friends", "access_token" => session[:access_token]).body
		puts @response
		redirect_to "/account"
	end

	def req

	end
	
	private

  def user_login_params
    params.permit(:username, :pass)
  end

  def user_signup_params
    params.permit(:user, :email, :password)
  end  

  def venmo_params
  	params.permit(:money)
  end

end
