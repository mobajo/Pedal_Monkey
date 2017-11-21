# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all

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





puts 'seed created'
