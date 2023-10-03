class MoviesController < ApplicationController
  def destroy
     # Retrieve the Movie ID value
     the_id = params.fetch("an_id")
     # Search the ID column for matching relation
     matching_records = Movie.where( :id => the_id)
     # Take the first element out of the relation
     the_movie = matching_records.at(0)
     # Delete the record
     the_movie.destroy

      # Redirects to /movies URL
      redirect_to("/movies")
  end

  def create
    # Create a record in movie table
    m = Movie.new

    # Retrieve user input from params
    m.title = params.fetch("query_title")
    m.year = params.fetch("query_year")
    m.duration = params.fetch("query_duration")
    m.description = params.fetch("query_description")
    m.image = params.fetch("query_image")
    m.director_id = params.fetch("query_director_id")

    # Save
    m.save
    # Redirect to /movies URL 
    redirect_to("/movies")

  end

  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
