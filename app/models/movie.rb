class Movie < ActiveRecord::Base
  
  def self.ratings()
    ratings = []
    movies = Movie.all
    movies.each { |m|
      if not ratings.include?(m.rating)
        ratings << m.rating
      end
    }
    return ratings
  end
  
end
