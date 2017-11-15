# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Province.create([
                  { province_code: 'MB', name: 'Manitoba', gst: 0.05, pst: 0.07, hst: 0 },
                  { province_code: 'AB', name: 'Alberta', gst: 0.05, pst: 0, hst: 0 }
                ])

admin_password = BCrypt::Password.create('admin')
usr = User.new(first_name: 'Admin', last_name: 'Adminison',
               email: 'admin', is_admin: true, password_digest: admin_password)

loc = Location.new(address: 'Admin Address',
                   postal_code: 'R2V4W8',
                   province: Province.first)

loc.user = usr
usr.save
loc.save

Product.create(name: 'Wood Salt Lamp Holder',
               description: 'Natural himalaya salt release anion, purifying and disinfect the air, reduce electromagnetic radiation.
AC 110V UL list electric-cord powered, completely safety.
Natural orange lighting source, create a warm and relax atmosphere.
Lighting source is a 15W halogen bulb,which is replaceable, with 1pc backup bulb.
Small himalaya salt chunks ,no need worry salt strike and crash.',
               price: 19.59, stock_quantity: 3, category: 'household')

Product.create(name: 'Pillar Lamp',
               description: 'This is a Lamp Base for a DIY Table Lamp. The package contains only lamp-stand.
Please note that the lamp shade, hardware, wires, plugs and lamp holder are not included. You need to buy that separately.
The lamp base is made in Shabby-Chic Art and comes in a vintage, Victorian look.
Handcrafted and Hand-Painted. Material: Wood.
Dimensions: 15 x 5 x 5 inches.',
               price: 15.99, stock_quantity: 5, category: 'household')

Product.create(name: 'Twisting Crab Toy', description: "With a smooth, rounded shell, six contoured legs and bright-red coloring, First Play Twisting Crab is a treat for baby's hands and eyes! The pleasing textures and movements invite grasping and exploration, promoting key developmental skills naturally. Made with select hardwood and child-safe dyes and tested to the highest standards of safety, this wooden toy is a thoughtful gift for new parents or the new baby in your house. Includes a parent-and-child activity book to inspire open-ended interactive play.",
               price: 13.29, stock_quantity: 55, category: 'toys')
