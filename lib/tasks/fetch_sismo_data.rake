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

      seismic_data = {
        data: [],
        pagination: {
          current_page: 1, # Este valor puede variar dependiendo de cómo implementes la paginación
          total: data['metadata']['count'],
          per_page: data['metadata']['count']
        }
      }

      # Iterar sobre cada feature y agregarlo al array de datos
      data['features'].each do |feature|
        attributes = feature['properties']

        # Validar los campos requeridos antes de agregar el feature al array de datos
        next unless attributes['title'] && attributes['url'] && attributes['place'] && attributes['magType'] && feature['geometry']['coordinates'].size >= 2

        seismic_data[:data] << {
          id: feature['id'],
          type: 'feature',
          attributes: {
            external_id: feature['id'],
            magnitude: attributes['mag'],
            place: attributes['place'],
            time: attributes['time'],
            tsunami: attributes['tsunami'],
            mag_type: attributes['magType'],
            title: attributes['title'],
            coordinates: {
              longitude: feature['geometry']['coordinates'][0],
              latitude: feature['geometry']['coordinates'][1]
            }
          },
          links: {
            external_url: attributes['url']
          }
        }
      end

      # Convertir el hash a formato JSON y mostrarlo en la consola
      puts JSON.pretty_generate(seismic_data)

      puts "Seismic data fetched and persisted successfully."

    rescue RestClient::ExceptionWithResponse => e
      puts "Error fetching seismic data: #{e.response}"
    rescue JSON::ParserError => e
      puts "Error parsing JSON response: #{e.message}"
    end
  end
end
