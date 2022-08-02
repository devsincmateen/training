# frozen_string_literal: true

require 'colorize'
require_relative 'functionalities'
require_relative 'date'
require_relative 'extraction'

# Module that has function that processes the wetherman command
class WeatherMan
  extend Extraction
  extend Functionality

  def self.execute
    arguments = extract_arg
    # p arguments
    case arguments[0]
    when 'a'
      avg_temp_humid_display(arguments)
    when 'e'
      temp_humid_display(arguments)
    when 'c'
      temp_bar_chart(arguments)
    else puts 'Invalid Case'
    end
  end
end
WeatherMan.execute
# [].methods
