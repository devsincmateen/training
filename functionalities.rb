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

  def print_max_avg(values)
    puts "Highest: #{values[0]} on #{get_month_string(values[1][1].to_i, true)} #{values[1][2]}"
  end

  def print_min_avg(values)
    puts "Lowest: #{values[0]} on #{get_month_string(values[1][1].to_i, true)} #{values[1][2]}"
  end

  def print_humid_avg(values)
    puts "Humid: #{values[0]} on #{get_month_string(values[1][1].to_i, true)} #{values[1][2]}"
  end

  def calculate(hash, string, val)
    values = []
    values.push(hash[string].compact.max)
    values.push(hash['PKT'][hash['Max TemperatureC'].index(values[0])])
    return values if val.length.zero?

    val[0] < values[0] ? values : val
  end

  def avg_temp_humid_display(arguments)
    max_temp_value = min_temp_value = max_humid_value = []
    get_dir(arguments).each do |i|
      hash = extract_data("#{arguments[2]}/#{i}")
      max_temp_value = calculate(hash, 'Max TemperatureC', max_temp_value)
      min_temp_value = calculate(hash, 'Min TemperatureC', min_temp_value)
      max_humid_value = calculate(hash, 'Max TemperatureC', max_humid_value)
    end

    print_max_avg(max_temp_value)

    print_min_avg(min_temp_value)

    print_humid_avg(max_humid_value)
  end

  def check_files?(filename)
    if filename.length.zero?
      puts 'Invalid Directory no files found'
      true
    end
    false
  end

  def self.file_exists?(file)
    return true if File.file?(file)

    false
  end

  def get_file_name(arguments, file)
    unless file
      filename = Dir.entries(arguments[2])
      filename.select! { |i| i.include?(arguments[1].year) }
      filename.select! { |i| i.include?(get_month_string(arguments[1].month, false).to_s) }
      filename = "#{arguments[2]}/#{filename[0]}"
      return filename
    end
    arguments[2]
  end

  def cal_humind_avg(hash)
    hash['Max Humidity'].compact.sum / hash['Max Humidity'].compact.size
  end

  def cal_max_avg(hash)
    hash['Max TemperatureC'].compact.sum / hash['Max TemperatureC'].compact.size
  end

  def cal_min_avg(hash)
    hash['Min TemperatureC'].compact.sum / hash['Min TemperatureC'].compact.size
  end

  def temp_humid_display(arguments, file)
    filename = get_file_name(arguments, file)
    unless file_exists?(filename) && filename.include?(get_month_string(arguments[1].month, false))
      puts 'Invalid File'
      return
    end
    hash = extract_data(filename)
    puts "Highest Average: #{cal_max_avg(hash)} \nLowest Average: #{cal_min_avg(hash)}"
    puts "Average Humidity: #{cal_humind_avg(hash)}"
  end

  def print_value_inner(val)
    print "#{val[1][2]} "
    j = val[0]
    j[0].times { print '+'.blue }
    j[1].times { print '+'.red }
    puts "#{j[0]}C - #{j[1]}C"
  end

  def print_values(values)
    values.each do |i|
      i.compact!
      next unless i[0].compact.length == 2

      print_value_inner(i)
    end
  end

  def temp_bar_chart(arguments, file)
    filename = get_file_name(arguments, file)
    return unless file_exists?(filename) && filename.include?(get_month_string(arguments[1].month, false))

    hash = extract_data(filename)
    max_temp = hash['Max TemperatureC']

    min_temp = hash['Min TemperatureC']
    date = hash['PKT']
    values = max_temp.zip(min_temp)
    values = values.zip(date)

    print_values(values)
  end
end
