class ColorScale < ApplicationRecord
  RED = "#d41414".freeze
  YELLOW = "#e2de19".freeze
  GREEN = "#3bc20f".freeze
  COLORS = {
    category_one: RED, category_two: YELLOW, category_three: GREEN
  }.freeze

  def color_for(value)
    value = value.round

    if category_two.cover?(value)
      COLORS[:category_two]
    elsif category_one.last > value
      COLORS[:category_one]
    elsif category_three.first < value
      COLORS[:category_three]
    end
  end

  def category_one
    @category_one ||= range(self[:category_one])
  end

  def category_two
    @category_two ||= range(self[:category_two])
  end

  def category_three
    @category_three ||= range(self[:category_three])
  end

  def width_for(category)
    category.size / all_categories_length.to_f * 100
  end

  def to_h
    as_json(only: %i[minimum maximum], methods: :categories)
  end

  def categories
    COLORS.map do |k, v|
      { key: k, color: v, width: width_for(send(k)) }
    end
  end

  def all_categories_length
    category_one.size + category_two.size + category_three.size
  end

  private

  def range(string_range)
    Range.new(*string_range.split("-").map(&:to_i))
  end
end
