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
end
