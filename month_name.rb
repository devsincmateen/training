# frozen_string_literal: true

# Module that return the string against month name
module MonthName
  # get full month string

  def get_month_string(num, type)
    hash = %w[January February March April May June July
              August September October Novembber December]
    type ? hash[num.to_i - 1] : hash[num.to_i - 1][0..2]
  end
end
