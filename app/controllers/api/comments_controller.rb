# app/controllers/api/comments_controller.rb
class Api::CommentsController < ApplicationController
  # Endpoint 2: POST crear un comment asociado a un feature
  def create
    feature = Feature.find_by(id: params[:feature_id])
    unless feature
      render json: { error: 'Feature not found' }, status: :not_found
      return
    end

    comment = feature.comments.build(body: params[:body])
    if comment.save
      render json: comment, status: :created
    else
      render json: { error: 'Failed to create comment', details: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
