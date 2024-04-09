RSpec.describe Api::FeaturesController, type: :controller do
  describe "GET index" do
    context "when no filters are provided" do
      it "returns a list of features with pagination" do
        get :index
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response["data"]).to be_an_instance_of(Array)
        expect(json_response["pagination"]).to be_an_instance_of(Hash)

        # Check each attribute type in the response
        json_response["data"].each do |feature|
          expect(feature["id"]).to be_an_instance_of(Integer)
          expect(feature["type"]).to eq("feature")
          expect(feature["attributes"]["external_id"]).to be_an_instance_of(String)
          expect(feature["attributes"]["magnitude"]).to be_a(Numeric)
          expect(feature["attributes"]["place"]).to be_an_instance_of(String)
          expect(feature["attributes"]["time"]).to be_an_instance_of(String)
          expect([true, false]).to include(feature["attributes"]["tsunami"])
          expect(feature["attributes"]["mag_type"]).to be_an_instance_of(String)
          expect(feature["attributes"]["title"]).to be_an_instance_of(String)
          expect(feature["attributes"]["coordinates"]["longitude"]).to be_a(Numeric)
          expect(feature["attributes"]["coordinates"]["latitude"]).to be_a(Numeric)
          expect(feature["links"]["external_url"]).to be_an_instance_of(String)
        end
      end
    end

    # Add more test cases for other scenarios as needed
  end
end
