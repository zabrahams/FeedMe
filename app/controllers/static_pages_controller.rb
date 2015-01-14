class StaticPagesController < ApplicationController

  skip_before_action :require_login


  def root
    if logged_in?
      render :root
    else
      render :root
    end
  end

end
