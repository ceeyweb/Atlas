class ColorScale < ApplicationRecord
  PRECISION = 2
  COLORS = %w[
    #28a745 #5baf35 #83b624 #a8bb10 #cdbf00 #dfb500 #f0aa00 #ff9e17 #fc8425
    #f56a31 #ea503c #dc3545
  ].freeze

  def color_for(value)
    if value < minimum
      colors.first
    elsif value >= maximum
      colors.last
    else
      colors[color_index_for(value)]
    end
  end

  def to_h
    as_json(only: %i[minimum maximum], methods: :colors)
  end

  private

  def colors
    if positive?
      COLORS
    else
      COLORS.reverse
    end
  end

  def color_index_for(value)
    ordered_ranges.each_index.detect { |i| ranges[i].cover?(value) }
  end

  def ordered_ranges
    if positive?
      ranges
    else
      ranges.reverse
    end
  end

  def ranges
    unit = (1.0 * 10**-PRECISION)

    (1..COLORS.size).map do |i|
      low = (minimum + (range_size * (i - 1))).round(PRECISION)
      high = (minimum + ((range_size * i) - unit)).round(PRECISION)

      low..high
    end
  end

  def range_size
    (maximum - minimum) / COLORS.size.to_f
  end
end
