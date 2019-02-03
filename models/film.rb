require_relative('./customer.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price, :showing_time

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
    @showing_time = options['showing_time']
  end

  def customer_count
    sql = "SELECT * FROM customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE customers.id = $1;"
    values = [@id]
    return SqlRunner.run(sql,values).count

  end

  def customer()
    sql = "SELECT * FROM customers
        INNER JOIN tickets
        ON customers.id = tickets.customer_id
        INNER JOIN films
        ON tickets.film_id = films.id
        WHERE films.id = 3;"
      values = [@id]
    result = SqlRunner.run(sql,values)
    return Customer.new(result[0])
  end

  def save()
    sql = "INSERT INTO films(title,price,showing_time)
    VALUES
    ($1,$2,$3)
    RETURNING id"
    values = [@title,@price,@showing_time]
    @id = SqlRunner.run(sql,values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE films
    SET (title,price,showing_time) = ($1,$2,$3)
    WHERE id = $4"
    values = [@title,@price,@showing_time,@id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values)
    return Film.new(result[0])
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
