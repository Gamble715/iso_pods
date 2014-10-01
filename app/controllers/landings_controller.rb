class LandingsController < ApplicationController
  def index
  end

  def about
  	@about = "This works the way it should"
  end

  def info
  	@info = "YAYAYAYAYAY!!!!"
  end

  def issue

  end

  def submit
    issue = Issue.new
    issue.email = params[:issue][:email]
    issue.message = params[:issue][:message]

    if issue.save
      redirect_to action: "index"
    else
      redirect_to action: "issue"
    end
  end

  def rent
    @visit = Visit.new
  end

  def terms

  end

  def ready

  end
end
