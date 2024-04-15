class Api::CommentsController < ApplicationController
  def index
    feature = Feature.find_by(id: params[:feature_id])
    unless feature
      render json: { error: 'Feature not found' }, status: :not_found
      return
    end

    comments = feature.comments
    render json: comments
  end

  def create
    feature = Feature.find_by(id: params[:feature_id])

    unless feature
      render json: { error: 'Feature not found' }, status: :not_found
      return
    end


    if params[:body].blank?
      render json: { error: 'Comment body cannot be empty' }, status: :unprocessable_entity
      return
    end

    comment = feature.comments.build(body: params[:body])

    if comment.save
      render json: comment, status: :created
    else
      render json: { error: 'Failed to create comment', details: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def destroy
    comment = Comment.find_by(id: params[:id])
    unless comment
      render json: { error: 'Comment not found' }, status: :not_found
      return
    end
    comment.destroy
    render json: { message: 'Comment deleted successfully' }
  end

  def update
    comment = Comment.find_by(id: params[:id])
    unless comment
      render json: { error: 'Comment not found' }, status: :not_found
      return
    end
    if comment.update(body: params[:body])
      render json: comment
    else
      render json: { error: 'Failed to update comment', details: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
