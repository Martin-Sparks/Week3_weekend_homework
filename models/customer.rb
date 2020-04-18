require_relative('../db/sql_runner')

class Customer
    attr_reader :id
    attr_accessor :name, :funds

    def initialize ( options )
        @id = options('id').to_i if options['id']
        @name = options['name']
        @funds = options['funds'].to_i
    end 

    def self.delete_all()
        sql = "DELETE FROM customers"
        SqlRunner.run(sql)
    end 

    def save()
        sql = 'INSERT INTO customers
        (name, funds) VALUES ($1, $2)
        RETURNING id'
        values = [@name, @funds]
        customer = SqlRunner.run(sql, values).first
        @id = customer['id'].to_i
    end 

    def self.all()
        sql = "SELECT * FROM customers"
        customer = SqlRunner.run(sql)
        return Customer.map_items(customer)
    end 

    def self.map_items(data)
        result = data.map{|customer| Customer.new(customer)}
    end 

    def update()
        sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
        values = [@name, @funds, @id]
        SqlRunner.run(sql, values)
      end
    
      def delete()
        sql = "DELETE FROM customers where id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
      end


    #   to Review 

      def bookings()
        sql = "SELECT customers.*
        FROM customers
        INNER JOIN tickets
        ON tickets.customer_id = customers.id
        WHERE tickets.film_id = $1"
        values = [@id]
        bookings = SqlRunner.run(sql, values)
        result = bookings.map {|booking| Customer.new(booking)}
        return result
      end 

end 