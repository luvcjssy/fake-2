class AccountController < ApplicationController
	def sign_in
		@user = Account.find_by_username('kai.251091@yahoo.com.vn')
		@title = "Sign in"
		session[:signin] = true
		session[:name] = @user.username
		redirect_to "/index"
	end

	def sign_out
		@title = "Sign out"
		session[:signin] = false
		redirect_to "/index"
	end

	def register
		@title = "Register"
		@account = Account.new
	end

	def sign_up
		@account = Account.new(account_params)
		
		if @account.save
			session[:signin] = true
			session[:name] = @account.username
			redirect_to '/index'
		else
			redirect_to '/register'
		end
		
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:username, :password)
    end
end
