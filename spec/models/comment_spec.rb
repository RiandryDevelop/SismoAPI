require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    before(:each) do
      @feature_id = 11665 
    end
   
    it "(POST) a comment from the api and test its field's values" do
     
      json_content = { feature_id: @feature_id, body: "Test on The One 2.0" }.to_json

      
      response = RestClient.post('http://localhost:3000/api/comments', json_content, { content_type: :json, accept: :json })
      expect(response.code).to eq(201)
      
      comment_data = JSON.parse(response.body)


      
      expect(comment_data['id']).to be_a(Integer)
      expect(comment_data['feature_id']).to be_a(Integer)
      expect(comment_data['body']).to be_a(String)
      expect(comment_data['created_at']).to be_a(String)
      expect(comment_data['updated_at']).to be_a(String)

      $comment_id = comment_data['id']
      puts comment_data
    end

    it "(GET) a comment from the api and test its field's values" do

      response = RestClient.get("http://localhost:3000/api/comments/feature/#{@feature_id}")
      comments_data = JSON.parse(response.body)

      expect(response.code).to eq(200)
      
      last_comment = comments_data[comments_data.size - 1]


      expect(last_comment['id']).to be_a(Integer)
      expect(last_comment['feature_id']).to be_a(Integer)
      expect(last_comment['body']).to be_a(String)
      expect(last_comment['created_at']).to be_a(String)
      expect(last_comment['updated_at']).to be_a(String)
      puts "#{last_comment}   id: #{$comment_id}"
    end

    it "(PUT) a comment from the api and test its field's values" do
      updated_json_content = { body: "Updated comment on 123_00"  }.to_json
      response = RestClient.put("http://localhost:3000/api/comments/#{$comment_id}", updated_json_content, { content_type: :json, accept: :json })
      expect(response.code).to eq(200)

      updated_comment_data = JSON.parse(response.body)

      expect(updated_comment_data['id']).to eq($comment_id)
      expect(updated_comment_data['body']).to eq("Updated comment on 123_00")
      expect(updated_comment_data['feature_id']).to be_a(Integer)
      expect(updated_comment_data['created_at']).to be_a(String)
      expect(updated_comment_data['updated_at']).to be_a(String)
      puts updated_comment_data
    end

    it "(DELETE) a comment from the api" do
     
      response = RestClient.delete("http://localhost:3000/api/comments/#{$comment_id}")
      expect(response.code).to eq(200)

      expect { RestClient.get("http://localhost:3000/api/comments/#{$comment_id}") }.to raise_error(RestClient::NotFound)
    end
  end
end
