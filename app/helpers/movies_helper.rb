module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def hilite_if(header, sorted_by)
    header == sorted_by ? "hilite" : ""
  end
  
  def rating_checked?(rating, ratings_checked)
    ratings_checked.has_key?(rating)
  end
  
  def hidden_field_if(name, value)
    if not value.empty?
      hidden_field_tag name, value
    end
  end
end
