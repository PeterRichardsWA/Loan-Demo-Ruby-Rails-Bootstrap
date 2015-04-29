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

    # get type common variables for both login types
    if params[:lender].nil? then # if nil, then borrower
      @login_type = params[:borrower][:type] # 1
      @borrower = Borrower.find_by_email(params[:borrower][:email]) # load info for this email
      @login_type = 1

    else
      @login_type = params[:lender][:type] # 2
      @lender = Lender.find_by_email(params[:lender][:email]) # load infor this email
      @login_type = 2

    end

    if @login_type == 1 then
      # Borrower type to load borrower email

      if @borrower.nil? then
        @borrower = Borrower.new # for redirect back to index to fill in form
        @borrower.errors.add(:account, ": was not found")
        to_page = users_index_path

      else

        if params[:borrower][:password] == @borrower[:password] then
          # Passwords matched - go for it
          session[:id] = @borrower[:id]
          session[:name] = @borrower[:first_name] + " " + @borrower[:last_name]
          session[:loan] = @borrower[:loan]
          session[:procured] = @borrower[:amount_procured]

          to_page = regborrowers_show_path

        else
          @lender = Lender.new
          @borrower.errors.add(:account, ": email and password match was not found")
          to_page = users_index_path

          render to_page

        end

      end

    # this section this is for login type of lender!
    elsif @login_type == 2 then

      # read lender details
      if @lender.nil? then
        # Need to add in ability to show errors on return to page
        @lender = Lender.new
        @lender.errors.add(:account, ": was not found")
        @borrower = Borrower.new

        to_page = users_index_path
        render to_page

      else

        if params[:lender][:password] == @lender[:password] then
          # success! Sweet
          session[:id] = @lender[:id]
          session[:name] = @lender[:first_name] + " " + @lender[:last_name]
          session[:lendable] = @lender[:lendable]

          to_page = reglenders_show_path

        else
          # password failed
          to_page = users_index_path
          @borrower = Borrower.new
          @lender.errors.add(:account, ": email and password match was not found")
          render to_page
        end

        # redirect_to to_page

      end

    end

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
