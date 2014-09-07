class AccountController < ApplicationController
	#GET UI LOGIN FORM
	def sign_in
		@title = "Sign in"
	end
	#POST DATA TO FORM LOGIN
	def log_in
		@title = "Sign in"

		@flag = false

		if params[:email] != nil
			if Account.authenticate(params[:email], params[:password])
				session[:signin] = true
				session[:name] = params[:email]
				session[:id] = Account.authenticate(params[:email],params[:password]).id
				redirect_to root_path
			else
				@flag = true
				render :sign_in
			end
		else
			@flag = true
		end
	end
	#LOGOUT 
	def sign_out
		@title = "Sign out"
		session[:signin] = false
		session[:name] = nil
		session[:id] = nil
		redirect_to root_path
	end
	#GET UI REGISTRATION FORM
	def register
		@title = "Register"
		@account = Account.new
	end
	#POST DATA TO REGISTRATION
	def sign_up
		@title = "Register"
		@account = Account.new(account_params)
		if @account.save
			session[:signin] = true
			session[:name] = @account.email
			session[:id] = @account.id
			redirect_to root_path
		else
			render :register
		end
	end

	#GET UI FORM MANAGE
	def manage
		#@account = Account.find_by_email(session[:email])
		@title = "Change Password"
	end
	#POST DATA TO CHANGE PASSWORD
	def edit
		@title = "Change Password"
		@flag1 = false
		@flag2 = false
		@flag3 = false
		@account = Account.find_by_email(session[:name])
		if @account.password == BCrypt::Engine.hash_secret(params[:account][:current_password], @account.salt)
			if params[:account][:password] == params[:account][:password_confirmation]
				if @account.update(:password => params[:account][:password], :password_confirmation => params[:account][:password_confirmation])
					redirect_to root_path
				else
					@flag3 = true
					render :manage
				end
			else
				@flag2 = true
				render :manage
			end
		else
			@flag1 = true
			render :manage
		end
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:email, :password, :password_confirmation)
    end

    def update_account_params
    	params.require(:account).permit(:current_password, :password, :password_confirmation)
    end
    
end
