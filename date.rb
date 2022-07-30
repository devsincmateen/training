# frozen_string_literal: true

# class manages the dates coming from input
class Date
  attr_accessor :year, :month, :day

  def initialize(year, month, day)
    @year = year
    @month = month
    @day = day
  end
end
