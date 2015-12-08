class Lender < ActiveRecord::Base

  has_many :histories
  has_many :borrowers, :through => :histories

  #define regex for check email validity
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :lendable, :numericality => { greater_than: 0 }, presence: true
  validates :first_name, :last_name, presence: true
  validates :email, format: { with: EMAIL_REGEX, message: "Not a valid email format" }, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: (4..20), message: "Password must be between 4 and 20 characters long. We recommend numbers with upper and lower case for strength"}
  validates_confirmation_of :password

  before_save do
      self.email.downcase!
  end

  def truncate_me!
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name}")
  end

end
