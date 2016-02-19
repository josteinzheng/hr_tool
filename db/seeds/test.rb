# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Setting.create(includeLastYear: false)

PASSWORD = ENV['RRD_HR_PASSWORD']
User.create(name: 'rrd-hr', email: 'rrd-hr@renrendai.com', password: PASSWORD, password_confirmation: PASSWORD)
