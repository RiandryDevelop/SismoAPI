class Api::CommentsController < ApplicationController
  # Endpoint para obtener todos los comentarios asociados a un feature
  def index
    feature = Feature.find_by(id: params[:feature_id])
    unless feature
      render json: { error: 'Feature not found' }, status: :not_found
      return
    end

    comments = feature.comments
    render json: comments
  end

  # Endpoint 2: POST crear un comment asociado a un feature
  def create
    # Buscar el feature por su ID
    feature = Feature.find_by(id: params[:feature_id])

    unless feature
      render json: { error: 'Feature not found' }, status: :not_found
      return
    end

    # Verificar que el body del comentario no esté vacío
    if params[:body].blank?
      render json: { error: 'Comment body cannot be empty' }, status: :unprocessable_entity
      return
    end

    # Construir el comentario asociado al feature
    comment = feature.comments.build(body: params[:body])

    # Persistir el comentario en la base de datos
    if comment.save
      render json: comment, status: :created
    else
      render json: { error: 'Failed to create comment', details: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Endpoint 3: DELETE para eliminar un comentario
  def destroy
    comment = Comment.find_by(id: params[:id])
    unless comment
      render json: { error: 'Comment not found' }, status: :not_found
      return
    end
    comment.destroy
    render json: { message: 'Comment deleted successfully' }
  end

  # Endpoint 4: UPDATE para actualizar un comentario existente
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
