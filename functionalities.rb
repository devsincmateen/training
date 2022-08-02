# frozen_string_literal: true

require_relative 'month_name'
require_relative 'date'
require_relative 'extraction'

# implements all the 3 functions
module Functionality
  include MonthName
  include Extraction

  def get_dir(arguments)
    filename = Dir.entries(arguments[2])
    filename.select! { |i| i.include?(arguments[1].year) }
    filename
  end

  def check_files(filename)
    if filename.length.zero?
      puts 'Invalid Directory no files found'
      true
    end
    false
  end

  def avg_temp_humid_display(arguments)
    max_temprature = max_humid = -999
    min_temprature = 9999
    max_day = min_day = max_humid_day = []
    filename = get_dir(arguments)
    return if check_files(filename)

    filename.each do |i|
      hash = extract_data("#{arguments[2]}/#{i}")

      if max_temprature < hash['Max TemperatureC'].compact.max
        max_temprature = hash['Max TemperatureC'].compact.max
        max_day = hash['PKT'][hash['Max TemperatureC'].index(max_temprature)]
      end
      if min_temprature > hash['Min TemperatureC'].compact.min
        min_temprature = hash['Min TemperatureC'].compact.min
        min_day = hash['PKT'][hash['Min TemperatureC'].index(min_temprature)]
      end
      if max_humid < hash['Max Humidity'].compact.max
        max_humid = hash['Max Humidity'].compact.max
        max_humid_day = hash['PKT'][hash['Max Humidity'].index(max_humid)]
      end
    end
    puts "Highest: #{max_temprature} on #{get_month_string(max_day[1].to_i, true)} #{max_day[2]}"
    puts "Lowest: #{min_temprature} on #{get_month_string(min_day[1].to_i, true)} #{min_day[2]}"
    puts "Humid: #{max_humid} on #{get_month_string(max_humid_day[1].to_i, true)} #{max_humid_day[2]}"
  end

  def temp_humid_display(arguments)
    filename = Dir.entries(arguments[2])
    filename.select! { |i| i.include?(arguments[1].year) }
    filename.select! { |i| i.include?(get_month_string(arguments[1].month, false).to_s) }
    # p filename
    return if check_files(filename)

    hash = extract_data("#{arguments[2]}/#{filename[0]}")
    avg_max_temp = hash['Max TemperatureC'].compact.sum / hash['Max TemperatureC'].compact.size
    avg_min_temp = hash['Min TemperatureC'].compact.sum / hash['Min TemperatureC'].compact.size
    maxh = hash['Max Humidity'].compact.sum / hash['Max Humidity'].compact.size
    puts "Highest Average: #{avg_max_temp} \nLowest Average: #{avg_min_temp} \nAverage Humidity: #{maxh}"
  end

  def print_values(values)
    values.each_with_index do |i, ind|
      i.compact!
      next unless i.length == 2

      print "#{ind} "
      i[0].times { print '+'.blue }
      i[1].times { print '+'.red }
      puts "#{i[0]}C - #{i[1]}C"
    end
  end

  def temp_bar_chart(arguments)
    filename = get_dir(arguments)
    filename.select! { |i| i.include?(get_month_string(arguments[1].month, false).to_s) }
    # p filename
    if check_files(filename)
      return 
    end
    hash = extract_data("#{arguments[2]}/#{filename[0]}")

    max_temp = hash['Max TemperatureC']

    min_temp = hash['Min TemperatureC']
    values = max_temp.zip(min_temp)
    print_values(values)
  end
end
