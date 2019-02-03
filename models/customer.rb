require_relative("../db/SqlRunner.rb")
require_relative("./film.rb")

class Customer

  attr_reader :id, :funds
  attr_accessor :name

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def reduce_money(value)
    @funds -= value
  end

  def tickets_bought_count()
    sql = "SELECT * FROM films
      INNER JOIN tickets
      ON tickets.film_id = films.id
      WHERE films.id = $1;"
    values = [@id]
    return SqlRunner.run(sql,values).count
  end

  def films()
    sql = "SELECT *
        FROM films
        INNER JOIN tickets
        ON films.id = tickets.film_id
        INNER JOIN customers
        ON tickets.customer_id = customers.id
        WHERE customers.id = $1;"
      values = [@id]
    results = SqlRunner.run(sql,values)
    return results.map {|film| Film.new(film)}
  end

  def save()
    sql = "INSERT INTO customers (name,funds)
    VALUES
    ($1,$2)
    RETURNING id
    "
    values = [@name,@funds]
    @id = SqlRunner.run(sql,values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE customers
    SET (name,funds) = ($1,$2)
    WHERE id = $3"
    values = [@name,@funds,@id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values)
    return Customer.new(result[0])
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
