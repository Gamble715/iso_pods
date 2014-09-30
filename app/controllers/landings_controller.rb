class LandingsController < ApplicationController
  def index
  end

  def about
  	@about = "This works the way it should"
  end

  def info
  	@info = "YAYAYAYAYAY!!!!"
  end

  def rent
    @visit = Visit.new
  end

  def terms

  end

  def ready

  end
end
