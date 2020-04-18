require_relative('../db/sql_runner')

class Ticket
    attr_reader :id
    attr_accessor :customer_id, :films_id

    def initialize (options)
        @id = options('id').to_i if options['id']
        @customer_id = options['customer_id'].to_i
        @films_id = options['films_id'].to_i
    end 
    
    def save()
        sql = "INSERT INTO tickets
        (customer_id, films_id) VALUES ($1, $2)
        RETURNING id"
        values = [@customer_id, @films_id]
        ticket = SqlRunner.run(sql, values).first
        @id = ticket['id'].to_i
    end 

    def self.delete_all()
        sql = "DELETE FROM tickets"
        SqlRunner.run(sql)
    end 

    def self.all()
        sql = "SELECT * FROM tickets"
        ticket = SqlRunner.run(sql)
        return Ticket.map_item(ticket)
    end 

    def self.map_items(data)
        result = data.map{|ticket| Ticket.new(ticket)}
    end 

    def update()
        sql = "UPDATE tickets SET (customer_id, films_id) = ($1, $2) WHERE id = $3"
        values = [@customer_id, @films_id, @id]
        SqlRunner.run(sql, values)
      end
    
      def delete()
        sql = "DELETE FROM tickets where id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
      end

end 
