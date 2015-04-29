module ApplicationHelper
	#converts entered numbers to currency
	def number_to_currency(number, options = {})
		options[:locale] ||= I18n.locale
		super(number, options)
	end
	# converts to cents
	def normalize_money(number)
		return number.to_s.delete(",.$")
	end
end
