# frozen_string_literal: true

# Module that return the string against month name
module Monthname
  # get full month string

  def get_month_string(num, type)
    hash = %w[January February March April May June July
              August September October Novembber December Jan Feb Jan Mar Apr May Jun Jul
              Aug Sep Oct Nov Dec]
    type ? hash[num.to_i - 1] : hash[num.to_i + 12]
  end
end
