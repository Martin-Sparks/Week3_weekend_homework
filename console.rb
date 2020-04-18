require_relative('models/tickets')
require_relative('models/customers')
require_relative('models/films')

require('pry')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({"name" => "David Frost", 'funds' => 200})
customer1.save()
customer2 = Customer.new({"name" => "Martin Sparks", 'funds' => 300})
customer2.save()
customer3 = Customer.new({"name" => "Rachel Smith", 'funds' => 150})
customer3.save()


film1 = Film.new({'title' => 'Alien', 'price' => 25})
film1.save()
film2 = Film.new({'title' => 'Men In Black', 'price' => 2})
film2.save()
film3 = Film.new({'title' => 'Happy Gilmore', 'price' => 30})
film3.save()


ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
# ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
# ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
# ticket3.save()

binding.pry
nil

