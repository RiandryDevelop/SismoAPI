class FeatureSerializer
  def initialize(feature)
    @feature = feature
  end

  def as_json(*)
    {
      id: @feature.id,
      type: 'feature',
      attributes: {
        external_id: @feature.external_id,
        magnitude: @feature.magnitude,
        place: @feature.place,
        time: format_time(@feature.time), 
        tsunami: @feature.tsunami,
        mag_type: @feature.mag_type,
        title: @feature.title,
        coordinates: {
          longitude: @feature.longitude,
          latitude: @feature.latitude
        }
      },
      links: {
        external_url: @feature.url
      }
    }
  end

  private

  def format_time(time)
    time.strftime("%Y-%m-%d %H:%M:%S") 
  end
end
