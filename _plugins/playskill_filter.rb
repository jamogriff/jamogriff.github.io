module Jekyll
  module PlaySkillFilter
    def play_skill(rating)
      case rating
      when 1
        "Wishlist"
      when 2
        "Bits & Pieces"
      when 3
        "Recognizable"
      when 4
        "Proficent"
      when 5
        "Mastery"
      when 6
        "Play & Sing"
      else
        "Unknown"
      end
    end

    def play_skill_color(rating)
      case rating
      when 1
        "orange-border"
      when 2
        "yellow-border"
      when 3
        "green-border"
      when 4
        "aqua-border"
      when 5
        "blue-border"
      when 6
        "purple-border"
      else
        "red-border"
      end
    end

  end
end

Liquid::Template.register_filter(Jekyll::PlaySkillFilter)
