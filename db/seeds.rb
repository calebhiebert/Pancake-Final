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

usr = User.create(first_name: 'Caleb',
            last_name: 'Hiebert',
            email: 'calebkhiebert@gmail.com')

prd = Product.create(name: 'Generic Wooden Trinket',
               description: 'Wood',
               price: 1.55,
               stock_quantity: 5)

ord = usr.order.create(status: 'UNFILLED', pst: 0.1, gst: 0.15)

ord.products.add(prd)