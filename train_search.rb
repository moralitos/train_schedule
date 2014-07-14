class TrainSearch
  def initialize(data)
    @data = data
  end

  def rows
    @rows ||= @data.map {|row| Row.new(row)}
  end

  # { name: '01251', start_date: '2014-04-24 22:03:00', start_location: 'A', end_date: '2014-04-24 22:10:00', end_location: 'BC' }
  def find_train(train_number)
    rows.find { |row| row.name == train_number }
  end


  def find_next_route(after_time, end_location)
    rows.find { |row| row.start_date > after_time and row.start_location == end_location }
  end

  def find_train_and_next_routes(train_number)
    train = find_train(train_number)
    routes = [train] # add the train as the first route

    # we search first to see if we find a route
    # we reassign the train variable to the new train found
    if(train = find_next_route(train.end_date, train.end_location))
      routes << train
    end
    # at the end return the train and the routes
    return routes
  end


  # Do this because we need to parse the date into a time to sort
  class Row
    def initialize(row)
      @row = row
    end

    def start_date
      DateTime.parse(@row[:start_date])
    end

    def end_date
      DateTime.parse(@row[:end_date])
    end

    def name
      @row[:name]
    end

    def start_location
      @row[:start_location]
    end

    def end_location
      @row[:end_location]
    end
  end
end
