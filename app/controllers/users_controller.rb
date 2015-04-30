class UsersController < ApplicationController
  # user login and also encryption. then also controls login.must be shared between both logins
  def index
  	@lender = Lender.new
  	@borrower = Borrower.new
  end

  def new

  end

  def create

  end

  def login

  end

  def logout
  	# logout process
  	session.destroy
  	redirect_to('/')

  end

private

	def encrypt_password
		self.salt = Digest::SHA2.hexadigest('#(Time.now.utc)--#(self.password)') if self.new_record?
		self.encrypted_password = encrypt(self.password)
	end

	def encrypt(pass)
		Digest::SHA2.hexadigest('#(self.salt)--#(pass)')
	end

	def lender_login
		params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :type)
	end

	def borrower_params
		params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :type)
	end


end
