# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first

# need to delete all first or this will insert dupes. destroys all with truncate.
#
# ActiveRecord::Base.establish_connection
# ActiveRecord::Base.connection.tables.each do |table|
#   next if table == 'schema_migrations'

#   # MySQL and PostgreSQL
#   ActiveRecord::Base.connection.execute("TRUNCATE #{table}") # wipe all tables

#   # SQLite
#   # ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
# end

Borrower.create(first_name: 'George', last_name: 'Harrison', email: 'george@user.com', password: '1234')
Borrower.create(first_name: 'Ringo', last_name: 'Starr', email: 'ringo@user.com', password: '1234')
Borrower.create(first_name: 'John', last_name: 'Lennon', email: 'lennon@user.com', password: '1234')
Borrower.create(first_name: 'Paul', last_name: 'McCartney', email: 'paul@user.com', password: '1234')
Borrower.create(first_name: 'Homer', last_name: 'Simpson', email: 'homer@user.com', password: '1234')
Borrower.create(first_name: 'Peter', last_name: 'Griffin', email: 'peter@user.com', password: '1234')
Borrower.create(first_name: 'DJ', last_name: 'Tiesto', email: 'dj@user.com', password: '1234')

Lender.create(first_name: 'Sherlock', last_name: 'Holmes', email: 'sherlock@user.com', password: '1234', lendable: 230223)
Lender.create(first_name: 'Joan', last_name: 'Watson', email: 'joan@user.com', password: '1234', lendable: 3092834)
Lender.create(first_name: 'Tony', last_name: 'Stark', email: 'tony@user.com', password: '1234', lendable: 9823409098)

History.create(loan: 3415234, amount_procured: 0, needed_for: 'New Guitar', description: 'Going on tour and need a new piece.', lender_id: 0, borrower_id: 1)
History.create(loan: 7467, amount_procured: 0, needed_for: 'new boat', description: 'Want to take a boating ride.', lender_id: 0, borrower_id: 2)
History.create(loan: 150, amount_procured: 0, needed_for: 'Headed East', description: 'Bus ticket needed.', lender_id: 0, borrower_id: 3)
History.create(loan: 225, amount_procured: 0, needed_for: 'Superbowl Tickets', description: 'Found tickets on craigslist. Gotta be real?', lender_id: 0, borrower_id: 4)
History.create(loan: 234, amount_procured: 0, needed_for: 'Food', description: 'Buy some food at the fair.', lender_id: 0, borrower_id: 5)
History.create(loan: 97897, amount_procured: 0, needed_for: 'Property', description: 'Found a great deal on property.', lender_id: 0, borrower_id: 6)
