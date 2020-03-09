class MobilityController < ApplicationController
  def index; end

  def show
    data = {
      regions: [
        { description: "Centro", value: "45.55" },
        { description: "Norte", value: "55.55" },
      ],
      genders: [
        { description: "Hombre", value: "12.12", color_index: 1 },
        { description: "Mujer", value: "34.34", color_index: 2 },
      ],
      title: "Movilidad intergeneracional en salud - Persistencia quintil I",
      description: "Porcentaje de personas que al igual que sus padres permacen al quintil más bajo de salud.",
      color_scale: { min: 30, max: 70, direction: :right },
    }

    render json: data
  end
end
