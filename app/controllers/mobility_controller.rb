class MobilityController < ApplicationController
  def index; end

  def show
    quintile = Quintile.find_by(slug: params["slug"])

    render json: quintile.to_h(params["gender"].presence)
  end
end
