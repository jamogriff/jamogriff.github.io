module Jekyll
  module TimeSinceFilter
    def time_since(current_time, year)
      current_time.year - year
    end
  end
end

Liquid::Template.register_filter(Jekyll::TimeSinceFilter)
