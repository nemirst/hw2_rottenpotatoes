class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sorted_by = ""
    @checked_ratings = {}
    filter = {}
    if params.has_key?(:sort_by)
      @sorted_by = params[:sort_by]
    end
    if params.has_key?(:ratings)
      @checked_ratings = params[:ratings]
      filter[:rating] = @checked_ratings.keys
    else
    end
    @movies = Movie.find(:all, :conditions => filter, :order => @sorted_by)
    @all_ratings = Movie.ratings()
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
