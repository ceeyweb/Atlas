class UpwardMobilityIndicatorController < ApplicationController
  def show
    @data = UpwardMobilityIndicator.where_indicator(slug: mobility_params).scatter_data

    if request.xhr?
      return render json: @data
    end
  end

  private

  def mobility_params
    params.require(:slug)
  end
end
