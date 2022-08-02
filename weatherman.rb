# frozen_string_literal: true

require 'colorize'
require_relative 'functionalities'
require_relative 'date'
require_relative 'extraction'

# Module that has function that processes the wetherman command
class WeatherMan
  extend Extraction
  extend Functionality

  def self.directory_exists?(directory)
    return true if File.directory?(directory)

    false
  end

  def self.file_exists?(file)
    return true if File.file?(file)

    false
  end

  def self.start(arguments, directory, file)
    x = directory || file
    case arguments[0]
    when 'a'
      temp_humid_display(arguments, file) if x
    when 'e'
      avg_temp_humid_display(arguments)
    when 'c'
      temp_bar_chart(arguments, file) if x
    else puts 'Invalid Case'
    end
  end

  def self.execute
    arguments = extract_arg
    directory = directory_exists?(arguments[2])
    file = file_exists?(arguments[2])
    start(arguments, directory, file)
  end
end
WeatherMan.execute
# [].methods
