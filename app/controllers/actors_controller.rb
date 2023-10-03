class ActorsController < ApplicationController
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
