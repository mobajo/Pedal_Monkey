# yey

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all

models = [User, TripMember, Trip, Stage, Pitstop]

models.each do |model|
  model.destroy_all
end


url = "https://media.licdn.com/mpr/mpr/shrinknp_200_200/p/2/000/0d2/278/3564222.jpg"
user1 = User.new(
  username: "Jimbo",
  email: "jim.sterling@gmail.com",
  first_name: "Jim",
  last_name: "Sterling",
  password: "123456",
  description: "Cycling fan and amateur chef")
user1.save
user1.photo_url = url

url = "https://www.exeter.ac.uk/media/universityofexeter/communicationservices/responsive-images/rob-mitchell.jpg"
user2 = User.new(
  username: "wiggo",
  email: "chris.Smith@sky.com",
  first_name: "Chris",
  last_name: "Smith",
  password: "123456",
  description: "Experienced cycle tourist")
user2.save
user2.photo_url = url

url = "https://media-exp2.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAAv_AAAAJDhlMmJkYTU5LTJiNDQtNDZkNi05MDEwLWFlNWY3ZDVlMjkzOA.jpg"
user3 = User.new(
  username: "ilovecycling1968",
  email: "johnbell@aol.com",
  first_name: "John",
  last_name: "Bell",
  password: "123456",
  description: "Office manager and cycling nut.")
user3.save
user3.photo_url = url

url = "http://s202719.gridserver.com/wp-content/uploads/rob.jpg"
user4 = User.new(
  username: "wppete",
  email: "petehorensby@stockport.com",
  first_name: "Peter",
  last_name: "Hornsby",
  password: "123456",
  description: "Cycled around the world in 500 days")
user4.save
user4.photo_url = url

url = "http://d3n8a8pro7vhmx.cloudfront.net/australianlaborparty/pages/158/meta_images/original/Rob_Mitchell3x3.jpg?1465193206"
user5 = User.new(
  username: "chrismcdermot",
  email: "cmcdermot@aol.com",
  first_name: "Chris",
  last_name: "Mcdermot",
  password: "123456",
  description: "bla bla bla bla")
user5.save
user5.photo_url = url

url = "http://moziru.com/images/profile-clipart-generic-user-7.png"
user6 = User.new(
  username: "Guest",
  email: "guest@pedalmonkey.world",
  first_name: "Guest",
  last_name: "Visitor",
  password: "123456",
  description: "Just having a look around")
user6.save
user6.photo_url = url
puts '6 users created'

trip1 = Trip.new(
  title: "Manchester to Bristol",
  distance: 297
  )
trip1.save
puts '1 trip created'

trip_member1 = TripMember.new(
  user: user1,
  trip: trip1,
  )
trip_member1.save

trip_member2 = TripMember.new(
  user: user2,
  trip: trip1,
  )
trip_member2.save

trip_member3 = TripMember.new(
  user: user3,
  trip: trip1,
  )
trip_member3.save

puts '3 trip_members created'

stage1 = Stage.new(
  stage_no: 1,
  trip: trip1,
  stage_date: Date.today,
  )
stage1.save

stage2 = Stage.new(
  stage_no: 2,
  trip: trip1,
  stage_date: Date.today + 1.day,
  )
stage2.save

stage3 = Stage.new(
  stage_no: 3,
  trip: trip1,
  stage_date: Date.today + 2.days,
  )
stage3.save

puts '3 stages created'

pitstop1 = Pitstop.new(
  name: 'starting point',
  address: 'Manchester, UK',
  price: 0,
  rating: 5,
  start_stage: stage1,
  )
 pitstop1.save

pitstop2 = Pitstop.new(
  name: 'Shrewsbury Central Inn',
  address: 'Shrewsbury, UK',
  price: 200,
  rating: 4,
  end_stage: stage1,
  start_stage: stage2,
  )
 pitstop2.save


pitstop3 = Pitstop.new(
  name: 'Hereford YMCA',
  address: 'Hereford',
  price: 0,
  rating: 5,
  end_stage: stage2,
  start_stage: stage3,
  )
 pitstop3.save


pitstop4 = Pitstop.new(
  address: 'Bristol',
  price: 0,
  rating: 5,
  end_stage: stage3,
  )
 pitstop4.save



 puts '4 piststops saved'
