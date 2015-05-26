class LoansController < ApplicationController
  def index
  end

  def new
  	@history = History.new
  end

  def create
  end
end
