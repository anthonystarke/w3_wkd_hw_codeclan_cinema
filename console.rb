require_relative("./models/customer.rb")
require_relative("./models/film.rb")
require_relative("./models/ticket.rb")
require_relative("./models/screening.rb")
require('pry')

customer_1_details = {
  "name" => "Johny Jones",
  "funds" => 50
}

customer_2_details = {
  "name" => "Karla Philip",
  "funds" => 100
}

customer_3_details = {
  "name" => "Debbie Jones",
  "funds" => 150
}

customer_4_details = {
  "name" => "Siro Hall",
  "funds" => 90
}

film_1_details = {
  "title" => "Rock and Roll",
  "price" => 15,
  "showing_time" => "20:00"
}
film_2_details = {
  "title" => "Twister",
  "price" => 15,
  "showing_time" => "22:00"
}
film_3_details = {
  "title" => "Alien",
  "price" => 15,
  "showing_time" => "00:00"
}
film_4_details = {
  "title" => "The Ring",
  "price" => 15,
  "showing_time" => "02:00"
}

# customer_1 = Customer.new(customer_1_details)
# customer_2 = Customer.new(customer_2_details)
# customer_3 = Customer.new(customer_3_details)
# customer_4 = Customer.new(customer_4_details)
#
# customer_1.save()
# customer_2.save()
# customer_3.save()
# customer_4.save()

customer_1 = Customer.find(1)
customer_2 = Customer.find(2)
customer_3 = Customer.find(3)
customer_4 = Customer.find(4)

# film_1 = Film.new(film_1_details)
# film_2 = Film.new(film_2_details)
# film_3 = Film.new(film_3_details)
# film_4 = Film.new(film_4_details)
#
# film_1.save()
# film_2.save()
# film_3.save()
# film_4.save()

film_1 = Film.find(1)
film_2 = Film.find(2)
film_3 = Film.find(3)
film_4 = Film.find(4)

ticket_1_details = {
  "customer_id" => customer_1.id,
  "film_id" => film_3.id
}
ticket_2_details = {
  "customer_id" => customer_2.id,
  "film_id" => film_3.id
}
ticket_3_details = {
  "customer_id" => customer_2.id,
  "film_id" => film_1.id
}
ticket_4_details = {
  "customer_id" => customer_3.id,
  "film_id" => film_4.id
}
ticket_5_details = {
  "customer_id" => customer_4.id,
  "film_id" => film_2.id
}

# ticket_1 = Ticket.new(ticket_1_details)
# ticket_2 = Ticket.new(ticket_2_details)
# ticket_3 = Ticket.new(ticket_3_details)
# ticket_4 = Ticket.new(ticket_4_details)
# ticket_5 = Ticket.new(ticket_5_details)
#
# ticket_1.save()
# ticket_2.save()
# ticket_3.save()
# ticket_4.save()
# ticket_5.save()

screening_1_details = {
  "title" => film_1.title,
  "showing_time" => film_1.showing_time,
  "film_id" => film_1.id
}

screening_new = Screening.new(screening_1_details)

binding.pry
nil
