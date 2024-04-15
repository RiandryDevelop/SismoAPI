namespace :fetch_sismo_data do
  task :fetch => :environment do
  
    url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'

    begin
  
      response = RestClient.get(url)
      data = JSON.parse(response.body)

  
      data['features'].each do |feature|
        attributes = feature['properties']

  
        next unless attributes['title'] && attributes['url'] && attributes['place'] && attributes['magType'] && feature['geometry']['coordinates'].size >= 2

  
        time = Time.at(attributes['time'] / 1000) 

        
        Feature.create!(
          external_id: feature['id'],
          magnitude: attributes['mag'],
          place: attributes['place'],
          time: time,
          tsunami: attributes['tsunami'],
          mag_type: attributes['magType'],
          title: attributes['title'],
          longitude: feature['geometry']['coordinates'][0],
          latitude: feature['geometry']['coordinates'][1],
          url: attributes['url']
        )
      end

      puts "Sismo data fetched and persisted successfully."

    rescue RestClient::ExceptionWithResponse => e
      puts "Error fetching sismo data: #{e.response}"
    rescue JSON::ParserError => e
      puts "Error parsing JSON response: #{e.message}"
    end
  end
end
