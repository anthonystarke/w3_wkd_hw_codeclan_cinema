require_relative("../db/SqlRunner.rb")

class Screening

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film = options['film']
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


end
