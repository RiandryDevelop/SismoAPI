require 'test_helper'

class FetchSismoDataTaskTest < ActiveSupport::TestCase
  include WebMock::API

  test "fetch and persist seismic data" do
    # Configura WebMock para que intercepte y responda a las solicitudes HTTP
    stub_request(:get, 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson')
      .to_return(body: File.read('test/fixtures/sample_geojson_response.json'), status: 200)

    # Ejecuta la tarea
    Rake::Task['fetch_sismo_data:fetch'].invoke

    # Verifica que los datos se hayan persistido correctamente
    assert_equal 3, Feature.count

    # Verifica que los campos requeridos no sean nulos y los rangos sean válidos
    Feature.all.each do |feature|
      assert_not_nil feature.title
      assert_not_nil feature.url
      assert_not_nil feature.place
      assert_not_nil feature.mag_type
      assert_not_nil feature.longitude
      assert_not_nil feature.latitude
      assert_includes (-1.0..10.0), feature.mag, "Magnitude #{feature.mag} fuera del rango permitido"
      assert_includes (-90.0..90.0), feature.latitude, "Latitud #{feature.latitude} fuera del rango permitido"
      assert_includes (-180.0..180.0), feature.longitude, "Longitud #{feature.longitude} fuera del rango permitido"
    end

    # Verifica que no se dupliquen los registros
    Rake::Task['fetch_sismo_data:fetch'].invoke
    assert_equal 3, Feature.count, "No deben duplicarse los registros al lanzar la tarea más de una vez"
  end
end
