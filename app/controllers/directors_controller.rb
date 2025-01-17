class DirectorsController < ApplicationController
  def update
    # Retrieve director ID
    director_id = params.fetch("an_id")
    # Locate matching relation
    matching_records = Director.where( :id => director_id)
    # Pop out correct relation
    the_director = matching_records.at(0)
    # Overwrite values
    the_director.name = params.fetch("query_name")
    the_director.dob = params.fetch("query_dob")
    the_director.bio = params.fetch("query_bio")
    the_director.image = params.fetch("query_image")
    # Save
    the_director.save

    # Redirect to director details page
    redirect_to("/directors/#{the_director.id}")
  end

  def destroy
    # Retrieve the Director ID value
    the_id = params.fetch("an_id")

    # Search the ID column for matching relation
    matching_records = Director.where({ :id => the_id})
    # Take the first element out of the relation
    the_director = matching_records.at(0)
    # Delete the record
    the_director.destroy

    # Redirects to /directors URL
    redirect_to("/directors")
  end

  def create
    # Create a record in director table
    d = Director.new

    # Retrieve user input from params
    d.name = params.fetch("query_name")
    d.dob = params.fetch("query_dob")
    d.bio = params.fetch("query_bio")
    d.image = params.fetch("query_bio")

    # Save
    d.save

    # Redirect to /directors URL
    redirect_to("/directors")
  end

  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
