# frozen_string_literal: true

require_relative 'month_name'
require_relative 'date'
require_relative 'extraction'

# implements all the 3 functions
module Functionality
  include Monthname
  include Extraction

  def getdir(arguments)
    filename = Dir.entries(arguments[2])
    filename.select! { |i| i.include?(arguments[1].year) }
    filename
  end

  def a_function(arguments)
    getdir(arguments)
    max_temprature = max_humid = -99_999
    min_temprature = 99_999
    max_day = min_day = max_humid_day = []
    filename = getdir(arguments)
    filename.each do |i|
      hash = extract_data("#{arguments[2]}/#{i}")
      max = hash['Max TemperatureC']
      min = hash['Min TemperatureC']
      maxh = hash['Max Humidity']

      if max_temprature < max.compact.max
        max_temprature = max.compact.max
        max_day = hash['PKT'][max.index(max_temprature)]
      end
      if min_temprature > min.compact.min
        min_temprature = min.compact.min
        min_day = hash['PKT'][min.index(min_temprature)]
      end
      if max_humid < maxh.compact.max
        max_humid = maxh.compact.max
        max_humid_day = hash['PKT'][maxh.index(max_humid)]
      end
    end
    puts "Highest: #{max_temprature} on #{gfm_string(max_day[1].to_i)} #{max_day[2]}"
    puts "Lowest: #{min_temprature} on #{gfm_string(min_day[1].to_i)} #{min_day[2]}"
    puts "Humid: #{max_humid} on #{gfm_string(max_humid_day[1].to_i)} #{max_humid_day[2]}"
  end

  def e_function(arguments)
    filename = Dir.entries(arguments[2])
    filename.select! { |i| i.include?(arguments[1].year) }
    filename.select! { |i| i.include?(gm_string(arguments[1].month).to_s) }
    filename = filename[0]
    # p filename
    hash = extract_data("#{arguments[2]}/#{filename}")
    avg_max_temp = hash['Max TemperatureC'].compact.sum / hash['Max TemperatureC'].compact.size
    avg_min_temp = hash['Min TemperatureC'].compact.sum / hash['Min TemperatureC'].compact.size
    maxh = hash['Max Humidity'].compact.sum / hash['Max Humidity'].compact.size
    puts "Highest Average: #{avg_max_temp} \nLowest Average: #{avg_min_temp} \nAverage Humidity: #{maxh}"
  end

  def printvalues(values)
    values.each_with_index do |i, ind|
      i.compact!
      next unless i.length == 2

      print "#{ind} "
      i[0].times { print '+'.blue }
      i[1].times { print '+'.red }
      puts "#{i[0]}C - #{i[1]}C"
    end
  end

  def c_function(arguments)
    filename = getdir(arguments)
    filename.select! { |i| i.include?(gm_string(arguments[1].month).to_s) }
    # p filename
    hash = extract_data("#{arguments[2]}/#{filename[0]}")

    max_temp = hash['Max TemperatureC']

    min_temp = hash['Min TemperatureC']
    values = max_temp.zip(min_temp)
    printvalues(values)
  end
end
