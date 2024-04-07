# lib/tasks/fetch_seismic_data.rake
require 'rest-client'
require 'json'

namespace :fetch_sismo_data do
  task :fetch => :environment do
    # URL del feed de USGS para los últimos 30 días
    url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'

    begin
      # Realizar la solicitud HTTP
      response = RestClient.get(url)
      data = JSON.parse(response.body)

      # Iterar sobre cada feature y persistirlo en la base de datos
      data['features'].each do |feature|
        attributes = feature['properties']

        # Validar los campos requeridos antes de persistir
        next unless attributes['title'] && attributes['url'] && attributes['place'] && attributes['magType'] && feature['geometry']['coordinates'].size >= 2

        Feature.find_or_create_by(external_id: feature['id']) do |f|
          f.mag = attributes['mag']
          f.place = attributes['place']
          f.time = attributes['time']
          f.url = attributes['url']
          f.tsunami = attributes['tsunami']
          f.mag_type = attributes['magType']
          f.title = attributes['title']
          f.longitude = feature['geometry']['coordinates'][0]
          f.latitude = feature['geometry']['coordinates'][1]
        end
      end

      puts "Seismic data fetched and persisted successfully."
    rescue RestClient::ExceptionWithResponse => e
      puts "Error fetching seismic data: #{e.response}"
    rescue JSON::ParserError => e
      puts "Error parsing JSON response: #{e.message}"
    end
  end
end
