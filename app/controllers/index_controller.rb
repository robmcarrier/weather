require 'sinatra'
require 'yahoo_weatherman'

get '/' do
    @message = "hello world"
    erb :index
end

post '/' do
    @zipcode = params[:zipcode]
    if valid_zipcode(@zipcode) == true
        @forcast = get_weather(@zipcode)
        erb :forecast
    else
        @error = "Incorrect input"
        erb :index
    end
end

def get_weather(location)
    client = Weatherman::Client.new
    weather = client.lookup_by_location(location)
    today = Time.now.strftime('%w').to_i
    forcast = []

    def ctof(cel)
        far = cel * 1.8 + 32
        far = far.round(1)
    end

    weather.forecasts.each do |forecast|
        day = forecast['date']
        weekday = day.strftime('%w').to_i
        if weekday == today
            dayName = 'Today'
        elsif weekday == today + 1
            dayName = 'Tomorrow'
        else
            dayName = day.strftime('%A')
        end
        forcast << (dayName + ' is going to be ' + forecast['text'].downcase + ' with a low of ' + ctof(forecast['low']).to_s + ' and a high of ' +  ctof(forecast['high']).to_s)
    end

    forcast


end

def valid_zipcode(zip)
    if zip.length != 5
        false
    elsif (/\D/.match(zip))
        false
    else
        true
    end
end
