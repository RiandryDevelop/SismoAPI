require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      feature = Feature.create(title: 'Sample Feature', description: 'Sample Description')
      comment = Comment.new(feature_id: feature.id, body: 'This is a test comment')
      expect(comment).to be_valid
    end

    it 'is not valid without a body' do
      feature = Feature.create(title: 'Sample Feature', description: 'Sample Description')
      comment = Comment.new(feature_id: feature.id)
      expect(comment).not_to be_valid
      expect(comment.errors[:body]).to include("can't be blank")
    end

    it 'is not valid without a feature_id' do
      comment = Comment.new(body: 'This is a test comment')
      expect(comment).not_to be_valid
      expect(comment.errors[:feature_id]).to include("can't be blank")
    end

    it 'is not valid with a non-existent feature_id' do
      comment = Comment.new(feature_id: 999, body: 'This is a test comment')
      expect(comment).not_to be_valid
      expect(comment.errors[:feature]).to include("must exist")
    end
  end
end
