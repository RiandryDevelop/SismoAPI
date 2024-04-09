namespace :fetch_sismo_data do
  task :fetch => :environment do
    # URL del feed de USGS para los últimos 30 días
    url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'

    begin
      # Realizar la solicitud HTTP
      response = RestClient.get(url)
      data = JSON.parse(response.body)

      # Iterate over each feature and save it to the database
      data['features'].each do |feature|
        attributes = feature['properties']

        # Skip if any required fields are empty or null
        next unless attributes['title'] && attributes['url'] && attributes['place'] && attributes['magType'] && feature['geometry']['coordinates'].size >= 2

        # Convert the time attribute to a human-readable date format
        time = Time.at(attributes['time'] / 1000) # Assuming the timestamp is in milliseconds

        # Save the feature to the database
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
