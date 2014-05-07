class HomeController < ApplicationController
  def index
	@upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(6)
	@locations = Location.active.alphabetical.paginate(:page => params[:page]).per_page(5)
	@instructors = Instructor.active.alphabetical.paginate(:page => params[:page]).per_page(5) 
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
