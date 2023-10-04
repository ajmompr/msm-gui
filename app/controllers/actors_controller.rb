class ActorsController < ApplicationController
  def update
    # Get the ID out of params
    actor_id = params.fetch("an_id")
    # Look up the existing record
    matching_records = Actor.where( :id => actor_id)
    the_actor = matching_records.at(0)
    # Overwrite each column with values from user inputs
    the_actor.name = params.fetch("query_name")
    the_actor.dob = params.fetch("query_dob")
    the_actor.bio = params.fetch("query_bio")
    the_actor.image = params.fetch("query_image")
    # save
    the_actor.save

    # Redirect to the movies detail page
    redirect_to("/actors/#{the_actor.id}")
  end

  def destroy
    # Retreive the actor ID
    the_id = params.fetch("an_id")
    # Find the matching relation based on the actor ID
    matching_records = Actor.where( :id => the_id)
    # Pop-out the matching actor row
    the_actor = matching_records.at(0)
    # Destroy the actor row
    the_actor.destroy

    # Redirect to /actors URL
    redirect_to("/actors")
  end

  def create
     # Create a new actor record
     a = Actor.new
     # Retrieve user input
     a.name = params.fetch("query_name")
     a.dob = params.fetch("query_dob")
     a.bio = params.fetch("query_bio")
     a.image = params.fetch("query_image")
 
     # Save
     a.save
     # Redirect to actor list
     redirect_to("/actors")
  end

  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
