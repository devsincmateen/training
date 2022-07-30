# frozen_string_literal: true

require 'colorize'
require_relative 'functionalities'
require_relative 'date'
require_relative 'extraction'

# Module that has function that processes the wetherman command
module Weatherman
  include Extraction
  include Functionality

  def weather_man
    arguments = extract_arg
    # p arguments
    case arguments[0]
    when 'a'
      a_function(arguments)
    when 'e'
      e_function(arguments)
    when 'c'
      c_function(arguments)
    end
  end
end
include Weatherman

Weatherman.weather_man
# [].methods
