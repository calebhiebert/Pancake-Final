# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Province.create([
                  { province_code: 'MB', gst: 0.05, pst: 0.07, hst: 0 },
                  { province_code: 'AB', gst: 0.05, pst: 0, hst: 0 }
                ])

admin_password = BCrypt::Password.create('admin')
usr = User.new(first_name: 'Admin', last_name: 'Adminison',
            email: 'admin@email.email', is_admin: true, password_digest: admin_password)

loc = Location.new(address: 'Admin Address',
                   postal_code: 'R2V4W8',
                   province: Province.first)

loc.user = usr
usr.save
loc.save

Product.create(name: 'Generic Wooden Trinket',
               description: 'Wood',
               price: 1.55,
               stock_quantity: 5)