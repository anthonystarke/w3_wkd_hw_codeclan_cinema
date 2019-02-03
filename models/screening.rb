require_relative("../db/SqlRunner.rb")
require_relative("./ticket.rb")

class Screening

  attr_reader :film_id, :total_seats
  attr_accessor :film_title, :film_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_title = options['title']
    @film_time = options['showing_time']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO screenings(film_title,film_time,film_id)
    VALUES
    ($1,$2,$3)
    RETURNING id"
    values = [@film_title,@film_time,@film_id]
    @id = SqlRunner.run(sql,values)[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    Sqlrunner.run(sql,values)
  end

  def update()
    sql = "UPDATE films
    SET (film_title,film_time,film_id) = ($1,$2,$3)
    WHERE id = $4"
    values = [@film_title,@film_time,@film_id,@id]
    SqlRunner.run(sql,values)
  end

  def self.get_available_seats(film_id)
    sql = "SELECT title,COUNT(tickets.id) FROM films
        INNER JOIN tickets
        ON tickets.film_id = $1
        GROUP BY title
        ORDER BY COUNT(tickets.id) DESC;"
    values = [film_id]
    seats_available = 100 - SqlRunner.run(sql,values)[0]['count'].to_i
    return seats_available
  end

  def self.buy(customer,film)
    if customer.funds.to_i > film.price.to_i && self.get_available_seats(film.id) > 0
      customer.reduce_money(film.price.to_i)
      new_ticket = {
        "customer_id" => customer.id,
        "film_id" => film.id
      }
      return Ticket.new(new_ticket)
    end
    return false
  end

  def self.all_viewings()
    sql = "SELECT title, showing_time FROM films;"
    values = []
    result = SqlRunner.run(sql,values)
    result = result.map {|film| Film.new(film)}
    result.each do |film|
      p "Title: #{film.title} at #{film.showing_time}"
    end
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql,values)
  end

  def self.return_most_sold_show_time
    sql = "SELECT showing_time FROM films
        INNER JOIN tickets
        ON tickets.film_id = films.id
        GROUP BY films.title,showing_time, films.id
        ORDER BY COUNT(films.id) DESC;"
    values = []
    return SqlRunner.run(sql,values)[0]['showing_time']
  end
end
