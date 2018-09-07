class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def demoversion
    flash[:danger] = "Diese Funktion ist in der Online-Version deaktivert."

    redirect_to :back
  end

  def startmodell
    system "/Applications/GAMS24.7/sysdir/gams" + " vrpmodell"

    redirect_to help_path

  end

  private

  # Confirms a logged-in user.

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end


end
