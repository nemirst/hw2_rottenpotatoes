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
    end
    
    if not (params.has_key?(:commit) and params[:commit] == 'Refresh')
      redirect_params = {}
      if @checked_ratings.empty? and session.has_key?(:ratings) and not session[:ratings].empty?
        redirect_params[:ratings] = session[:ratings]
      end
      if @sorted_by.empty? and session.has_key?(:sort_by) and not session[:sort_by] == ''
        redirect_params[:sort_by] = session[:sort_by]
      end
      if not redirect_params.empty?
        redirect_params[:action] = 'index'
        redirect_to(redirect_params)
      end      
    end

    session[:ratings] = @checked_ratings  
    session[:sort_by] = @sorted_by
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
    flas[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
