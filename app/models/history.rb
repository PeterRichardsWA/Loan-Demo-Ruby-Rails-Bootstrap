class History < ActiveRecord::Base
	belongs_to :borrower
	belongs_to :lender

	attr_accessor :loan_amount
end
