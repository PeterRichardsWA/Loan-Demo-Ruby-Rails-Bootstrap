class History < ActiveRecord::Base
	belongs_to :borrower
	belongs_to :lender
	after_initialize :init

	attr_accessor :loan_amount

	validates :loan, :needed_for, :description, :borrower_id, presence: true
	validates :loan, numericality: true

	def init
		self.amount_procured	||= 0.0
		self.lender_id	||= 0
	end

end
