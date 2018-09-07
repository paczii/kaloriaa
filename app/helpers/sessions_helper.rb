module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end


  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def current_customer
    if current_user.driver?
    else
      @current_customer = Customer.find_by_user_id(session[:user_id])
    end
  end

  def current_cart
    if current_user.driver?
    else
      @current_cart = Cart.find_by_customer_id(Customer.find_by_user_id(session[:user_id]).id)
    end
  end



  def current_cart_size
    if logged_in? and current_user.driver? == false
    mycart = Cart.find_by_customer_id(session[:user_id])
    productsarray = mycart.products.split(",")
    @current_cart_size = productsarray.length
      end

  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

end