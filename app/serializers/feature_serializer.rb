# app/serializers/feature_serializer.rb
class FeatureSerializer
    def initialize(feature)
      @feature = feature
    end
  
    def as_json(*)
      {
        id: @feature.id,
        name: @feature.name,
        description: @feature.description,
        mag_type: @feature.mag_type
        # Add other attributes as needed
      }
    end
  end
  