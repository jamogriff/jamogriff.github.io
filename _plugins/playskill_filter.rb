module Jekyll
  module PlaySkillFilter
    def play_skill(rating)
      case rating
      when 0
        "Graveyard"
      when 1
        "Out of Rotation"
      when 2
        "Currently Playing"
      when 3
        "Ingrained"
      else
        "Unknown"
      end
    end

    def play_skill_color(rating)
      case rating
      when 0
        "red-border"
      when 1
        "orange-border"
      when 2
        "aqua-border"
      when 3
        "purple-border"
      else
        "red-border"
      end
    end

  end
end

Liquid::Template.register_filter(Jekyll::PlaySkillFilter)
