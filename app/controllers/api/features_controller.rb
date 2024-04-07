class Api::FeaturesController < ApplicationController
  # Endpoint 1: GET lista de features
  def index
    # Filtrar por mag_type si se proporciona
    if params[:filters] && params[:filters][:mag_type].present?
      mag_type = params[:filters][:mag_type]
      unless valid_mag_type?(mag_type)
        render json: { error: "Invalid mag_type value: #{mag_type}" }, status: :unprocessable_entity
        return
      end
      features = Feature.where(mag_type: mag_type)
    else
      features = Feature.all
    end

    # Paginar los resultados
    begin
      per_page = params[:per_page].to_i
      per_page = 20 if per_page <= 0 || per_page > 1000 # Default per_page if invalid

      # Replace 'page' and 'per' with 'paginate' provided by will_paginate gem
      features = features.paginate(page: params[:page], per_page: per_page)
    rescue ArgumentError => e
      render json: { error: "Invalid pagination parameter: #{e.message}" }, status: :unprocessable_entity
      return
    end

    render json: {
      data: features.map { |feature| FeatureSerializer.new(feature).as_json },
      pagination: {
        current_page: features.current_page,
        total: features.total_entries,
        per_page: features.per_page
      }
    }, status: :ok
  end

  private

  def valid_mag_type?(mag_type)
    # List of valid mag_types
    valid_mag_types = %w[md ml ms mw me mi mb mlg]
    valid_mag_types.include?(mag_type)
  end
end
