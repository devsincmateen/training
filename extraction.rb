# frozen_string_literal: true

# Modules that will extract data from Arguments and the files
module Extraction
  # extracts data from arguments
  def extract_arg
    args = []
    args << ARGV[0][-1]
    temp = ARGV[1].split('/')
    args << Date.new(temp[0], temp[1], temp[2])
    args << ARGV[2]
  end

  def make_hash(data, keys, hash)
    data.each do |d| # extracting numeric values from each line provided
      values = d.split(',')
      pkt = values[0].split('-')
      values.map! { |i| i == '' ? nil : i.to_i }
      values[0] = pkt
      values.each_with_index do |num, index| # adding data to the hash
        hash[keys[index]].push(num)
      end
    end
    hash
    # returning extracted values
  end

  # Extracting Data from File
  def extract_data(filename)
    file = File.open(filename, 'r')
    data = file.readlines
    keys = data[0].split(',') # spliting the first line that contains the column name
    data.delete_at(0)
    keys.map!(&:strip)
    hash = {} # hash that will store extracted data
    keys.each do |i|
      hash[i] = []
    end
    make_hash(data, keys, hash)
  end
end
