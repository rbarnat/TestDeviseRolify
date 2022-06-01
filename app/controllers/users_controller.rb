class UsersController < ApplicationController
  def index
    @users = User.order(created_at: :desc)
  end

  # def show

  # end

  # def new
  #   @user = User.new
  # end

  def edit 
    set_user
  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     redirect_to @user, notice: "User was successfully created."
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def update
    set_user
    if @user.update(user_params)
      redirect_to users_url, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @user.destroy
  #   redirect_to users.url, notice: "User was successfully destroyed."
  # end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, {role_ids:[]})
    end

end
