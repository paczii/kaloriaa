class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create


    @user = User.new(user_params)    # Not the final implementation!



    if @user.save

      log_in @user
      flash[:success] = "Erfolgreich angemeldet!"

      redirect_to edit_customer_path(@customer)

    else
      redirect_to new_user_path
    end



  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(customer_params)
        flash[:success] = "Kundendaten erfolgreich bearbeitet."
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @user = User.find(params[:id])
    if @user.admin?
      flash[:danger] = "Der Admin kann nicht gelöscht werden."

    else
     @user.destroy
     flash[:success] = "Kunde erfolgreich gelöscht."
     redirect_to users_url

    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :status, :driver)
  end

  # Before filters

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) or current_user.admin?
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
