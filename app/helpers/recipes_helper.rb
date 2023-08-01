module RecipesHelper
  def format_time(time_in_minutes)
    hours = time_in_minutes / 60
    minutes = time_in_minutes % 60

    time_string = ""
    time_string << "#{hours} hour#{'s' if hours != 1}" if hours > 0
    time_string << " #{minutes} minute#{'s' if minutes != 1}" if minutes > 0

    time_string
  end
end
