class ColorScale < ApplicationRecord
  # SIZE value must be equal to `$scale-colors` list size in stylesheet
  # _app/assets/stylesheets/mobility.scss_.
  SIZE = 12
  PRECISION = 2

  def ranges
    if positive?
      scale_ranges
    else
      scale_ranges.reverse
    end
  end

  def direction
    if positive?
      :right
    else
      :left
    end
  end

  def range_index_for(value)
    if value < minimum
      best_range_index
    elsif value >= maximum
      worst_range_index
    else
      ranges.each_index.detect { |i| ranges[i].cover?(value) }
    end
  end

  def to_h
    as_json(only: %i[minimum maximum], methods: :direction)
  end

  private

  def best_range_index
    return 0 if positive?

    SIZE - 1
  end

  def worst_range_index
    return 0 unless positive?

    SIZE - 1
  end

  def range_size
    (maximum - minimum) / SIZE.to_f
  end

  def scale_ranges
    unit = (1.0 * 10**-PRECISION)

    (1..SIZE).map do |i|
      low = (minimum + (range_size * (i - 1))).round(PRECISION)
      high = (minimum + ((range_size * i) - unit)).round(PRECISION)

      low..high
    end
  end
end
