RSpec.describe Feature, type: :model do
  describe "attributes" do
    it "should have the expected attributes" do
      feature = Feature.new(
        id: 1,
        magnitude: 5.0,
        place: "Test Place",
        time: Time.now,
        url: "http://example.com",
        tsunami: false,
        mag_type: "ml",
        title: "Test Title",
        longitude: 10.0,
        latitude: 20.0
      )

      expect(feature).to respond_to(:id)
      expect(feature).to respond_to(:magnitude)
      expect(feature).to respond_to(:place)
      expect(feature).to respond_to(:time)
      expect(feature).to respond_to(:url)
      expect(feature).to respond_to(:tsunami)
      expect(feature).to respond_to(:mag_type)
      expect(feature).to respond_to(:title)
      expect(feature).to respond_to(:longitude)
      expect(feature).to respond_to(:latitude)
    end
  end
end
