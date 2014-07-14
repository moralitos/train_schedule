require_relative 'train_search'



require 'debugger'

describe TrainSearch do

  let(:time_tables) { [
    { name: '01251', start_date: '2014-04-24 22:03:00', start_location: 'A', end_date: '2014-04-24 22:10:00', end_location: 'BC' },
    { name: '05012', start_date: '2014-04-24 22:20:00', start_location: 'RI', end_date: '2014-04-24 23:10:00', end_location: 'XX' },
    { name: '03232', start_date: '2014-04-24 17:10:00', start_location: 'X', end_date: '2014-04-24 20:10:00', end_location: 'B' },
    { name: '02435', start_date: '2014-04-24 17:10:00', start_location: 'Z', end_date: '2014-04-24 20:10:00', end_location: 'B' },
    { name: '04545', start_date: '2014-04-24 22:15:00', start_location: 'BC', end_date: '2014-04-24 22:20:00', end_location: 'RI' },
    { name: '03545', start_date: '2014-04-24 23:15:00', start_location: 'XX', end_date: '2014-04-25 00:10:00', end_location: 'E' }
    ]}

  let(:train_search) { TrainSearch.new(time_tables) }

  #if I enter this: '05012'- train_number I should get:
  #{ name: '05012', start_date: '2014-04-24 22:20:00', start_location: 'RI', end_date: '2014-04-24 23:10:00', end_location: 'XX' },
  #{ name: '03545', start_date: '2014-04-24 23:15:00', start_location: 'XX', end_date: '2014-04-24 00:10:00', end_location: 'E' }
  #if I enter this: '04545' train_number I should get:
  # { name: '04545', start_date: '2014-04-24 22:15:00', start_location: 'BC', end_date: '2014-04-24 22:20:00', end_location: 'RI' },
  # { name: '05012', start_date: '2014-04-24 22:20:00', start_location: 'RI', end_date: '2014-04-24 23:10:00', end_location: 'XX' },
  # { name: '03545', start_date: '2014-04-24 23:15:00', start_location: 'XX', end_date: '2014-04-25 00:10:00', end_location: 'E' }


  it "should find the train row by the train number requested" do
    train = train_search.find_train('05012')
    expect(train).to_not eq(nil)
    expect(train.end_location).to eq('XX')

  end

  it "should find the next route" do
    train = train_search.find_train('05012')
    next_row = train_search.find_next_route(train.end_date, train.end_location)
    expect(next_row).to_not eq(nil)
    expect(next_row.name).to eq('03545')
  end

  it "should find the routes for a train number" do
    routes = train_search.find_train_and_next_routes('05012')
    expect(routes).to_not eq([])
    expect(routes.map(&:name)).to eq(['05012','03545'])
  end


  it "should find the routes for a train number" do
    routes = train_search.find_train_and_next_routes('04545')
    expect(routes).to_not eq([])
    expect(routes.map(&:name)).to eq(['04545'])
  end

end
