# frozen_string_literal: true

# Module that return the string against month name
module Monthname
  def gm_string(num)
    case num
    when 1
      'Jan'
    when 2
      'Feb'
    when 3
      'Mar'
    when 4
      'Apr'
    when 5
      'May'
    when 6
      'Jun'
    when 7
      'Jul'
    when 8
      'Aug'
    when 9
      'Sep'
    when 10
      'Oct'
    when 11
      'Nov'
    when 12
      'Dec'
    end
  end

  # get full month string

  def gfm_string(num)
    case num
    when 1
      'January'
    when 2
      'February'
    when 3
      'March'
    when 4
      'April'
    when 5
      'May'
    when 6
      'June'
    when 7
      'July'
    when 8
      'August'
    when 9
      'September'
    when 10
      'October'
    when 11
      'Novembber'
    when 12
      'December'
    end
  end
end
