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

user1 = User.new(
  username: "makeitso",
  email: "captin@starfleet.com",
  first_name: "Jon-Luc",
  last_name: "Picard",
  password: "123456",
  description: "Captain of the USS Enterprise and cycling fan")
user1.save

user2 = User.new(
  username: "wiggo",
  email: "bradley.wiggins@sky.com",
  first_name: "Bradley",
  last_name: "Wiggins",
  password: "123456",
  description: "Only Mod to win the Tour_France")
user2.save

user3 = User.new(
  username: "livestrong",
  email: "Armstrong@epo.com",
  first_name: "Lance",
  last_name: "Armstrong",
  password: "123456",
  description: "7 time champion at the steroid olympics")
user3.save

user4 = User.new(
  username: "Aroundtheworld",
  email: "markbeaumont@80days.co.uk",
  first_name: "Mark",
  last_name: "Beaumont",
  password: "123456",
  description: "Cylcled arond the work in 80 days")
user4.save

user5 = User.new(
  username: "freecatalan",
  email: "acontardor@aol.com",
  first_name: "Alberto",
  last_name: "Contador",
  password: "123456",
  description: "Ratfaced drug cheat")
user5.save

puts '5 users created'

trip1 = Trip.new(
  title: "Manchester to Bristol",

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
  address: 'Manchester',
  price: 0,
  rating: 5,
  start_stage: stage1,
  )
 pitstop1.save

pitstop2 = Pitstop.new(
  name: 'First Night',
  address: 'Shrewbury',
  price: 200,
  rating: 4,
  end_stage: stage1,
  start_stage: stage2,
  )
 pitstop2.save


pitstop3 = Pitstop.new(
  name: 'last night',
  address: 'Hereford',
  price: 0,
  rating: 5,
  end_stage: stage2,
  start_stage: stage3,
  )
 pitstop3.save


pitstop4 = Pitstop.new(
  name: 'End point',
  address: 'Bristol',
  price: 0,
  rating: 5,
  end_stage: stage3,
  )
 pitstop4.save



 puts '4 piststops saved'
