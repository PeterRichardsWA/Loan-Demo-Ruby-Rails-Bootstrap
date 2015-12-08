class ReglendersController < ApplicationController

	include ActionView::Helpers::NumberHelper

	def new
		@lender = Lender.new
	end

	def create
		#create new lender here!
	  	@lender = Lender.new(lender_params)
	  	if @lender.save
  			# now that account created.  lets put amount in tranaction  table for reference.
  			session[:id] = lender[:id]
  			session[:name] = lender[:first_name] + " " + lender[:last_name]
  			session[:lendable] = lender[:lendable]

  			redirect_to reglenders_show_path

	  	else

	  		render 'new'
	  	end
	end

	def login

		@lender = Lender.find_by_email(params[:lender][:email]) # load infor this email

		# this section this is for login type of lender!
		# read lender details

		if @lender && params[:lender][:password] == @lender[:password] then
		  # success! Sweet
		  session[:id] = @lender[:id]
		  session[:name] = @lender[:first_name] + " " + @lender[:last_name]
		  session[:lendable] = @lender[:lendable]

		  redirect_to reglenders_show_path

		else
		  @lender = Lender.new
		  @lender.errors.add(:Account," : Unabale to process login.")
		  @borrower = Borrower.new
		  render users_index_path

		end

	end

	def addmoney

	end

	def savemoney
		lender = Lender.find(session[:id])
		addamount = number_with_precision(params[:amount], precision: 2).to_f
		lender.lendable += addamount
		lender.save
		session[:lendable] = lender.lendable
		redirect_to reglenders_show_path
	end

	def show
		# amount raised calculated from sums of individual loads. loans with same id, same lender and same borrower with show amount
		#  can break down later to make EACH transaction separate for record kepping and indivudual % rates.
		# @lender = Lender.find(session[:id]) # find logged in lender.
		#@borrowers = Borrower.all # need join that joins history with borrowers.
		if session[:id]
			if Lender.find(session[:id]).lendable
	    		# shows only loans I've lent to
    			@my_loans = Borrower.select("borrowers.first_name, borrowers.last_name, histories.*").joins(:histories).where("lender_id = ?",session[:id])
    		end
    	end

    	@loan_total = 0
    	@amount_total = 0
   		# shows loans that are available to lend to.
    	@open_loans = Borrower.select("borrowers.first_name, borrowers.last_name, histories.*").joins(:histories)#.where("amount_procured < loan OR lender_id = 0")

	end

	def update
		# want to use patch/put on this, but need to find method settings for this.
		#hold in this first. we are getting amount and id, so we can send the money to the right place.
		# can add all sorts of update messages, etc, here.
		@newloan = params[:newloan][:loan_amount].to_f
		@id = params[:id]
		@history = History.find(@id)
		if @history
			@history[:lender_id] = session[:id] #set lender id on newly aqcuired loans
			@history[:amount_procured] += @newloan
			if @history.save
				# successful save.  now take amount out of lender resources
				@lender = Lender.find(session[:id])
				@lender[:lendable] -= @newloan
				session[:lendable] = @lender[:lendable]
				@lender.save
			end
		end
		# regardless go back. can add a success banner if need
		redirect_to reglenders_show_path

	end

private

	def lender_params
		params.require(:lender).permit(:first_name, :last_name, :email, :password, :lendable)
	end

end
