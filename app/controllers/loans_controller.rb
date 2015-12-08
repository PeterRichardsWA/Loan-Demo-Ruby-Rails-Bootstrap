class LoansController < ApplicationController
  def index
  end

  def new
  	@history = History.new
  end

  def create
  	# history new here.  set values to fields. Then, save the new history to the database for future use
  	@loan_amount = 0
  	@reason = 0
  	@description = 0
  end
end
