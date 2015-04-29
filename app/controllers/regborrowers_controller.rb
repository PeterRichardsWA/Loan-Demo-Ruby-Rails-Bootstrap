class RegborrowersController < ApplicationController

  def new
  	@borrower = Borrower.new
  end

  def create
  	@borrower = Borrower.new(borrower_params)
  	if @borrower.save
        session[:id] = @borrower[:id]
        session[:name] = @borrower[:first_name] + " " + @borrower[:last_name]
        session[:loan] = @borrower[:loan]
        session[:procured] = @borrower[:amount_procured]

        redirect_to regborrowers_show_path
    else
      render 'new'
    end
  end

  def login

      @borrower = Borrower.find_by_email(params[:borrower][:email]) # load info for this email

      # Borrower type to load borrower email

      if @borrower && params[:borrower][:password] == @borrower[:password] then

        # need to lookup current loans
        # works: Lender.select("lenders.*, histories.*").joins(:histories).all
        #@lenders = Lender.select("lenders.email, lenders.first_name, lenders.last_name, histories.*").joins(:histories).where("borrower_id = 1")

        # Passwords matched - go for it
        session[:id] = @borrower[:id]
        session[:name] = @borrower[:first_name] + " " + @borrower[:last_name]
        session[:loan] = @borrower[:loan]
        session[:procured] = @borrower[:amount_procured]

        redirect_to regborrowers_show_path

      else
        @borrower = Borrower.new
        @lender = Lender.new
        @borrower.errors.add(:account, ": email and password match was not found")

        render users_index_path

      end

  end

  def show
  	# Need loans, an updated total of all loans, and updated total of all procured amounts
    session[:loan] = History.where("borrower_id = ?",session[:id]).sum(:loan)
    session[:procured] = History.where("borrower_id = ?",session[:id]).sum(:amount_procured)
    @lenders = Lender.select("lenders.email, lenders.first_name, lenders.last_name, histories.*").joins(:histories).where("borrower_id = ?",session[:id])
  end

private

	def borrower_params
		params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :description, :needed_for, :amount)
	end

end
