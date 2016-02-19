# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Setting.create(includeLastYear: false)

User.create(name: 'rrd-hr', email: 'rrd-hr@renrendai.com', password: '123456', password_confirmation: '123456')
User.create(name: 'zhengzhijie', email: 'zhengzhijie@renrendai.com', password: '10010731', password_confirmation: '10010731')
