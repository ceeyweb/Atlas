class UpwardMobilityIndicatorController < ApplicationController
  def index; end

  def show
    render json: UpwardMobilityIndicator.
      where_indicator(slug: mobility_params).scatter_data
  end

  private

  def mobility_params
    params.require(:slug)
  end
end
