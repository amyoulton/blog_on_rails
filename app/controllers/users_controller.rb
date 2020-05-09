class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create] 
    before_action :authorize!, only: [:edit, :update, :destroy, :password, :password_confirmation]
    

    def new
        @user = User.new
    end

    def create
        @user = User.new params.require(:user).permit(:name, :email, :password, :password_confirmation)
        if @user.save
          flash[:success] = "User Logged In"
          session[:user_id] = @user.id
          flash.delete(:warning)
          redirect_to root_path
        else
          flash[:warning] = "Unable to Create User"
          render :new
        end
      end

    def edit
        id = params[:id]
        @user = User.find(id)

    end

    def update
        id = params[:id]
        @user = User.find(id)
        if @user.update(params.require(:user).permit(:name, :email))
          flash[:success] = "User Updated"
          session[:user_id] = @user.id
          flash.delete(:warning)
          redirect_to root_path
        else
          flash[:warning] = "Unable to Update User"
          render :edit
        end
    end

    def password
        id = params[:id]
        @user = User.find(id)
    end

    def update_password
        @user = current_user
        user_params = params[:user]
        if (current_user.authenticate(user_params[:current_password]))
         if (user_params[:new_password] == user_params[:current_password])
            flash[:danger] = "Password Must Be Different"
            render :password
         elsif (user_params[:new_password] == user_params[:new_password_confirmation])
            if @user.update({password: user_params[:new_password]})
              flash[:success] = "Password Updated"
              redirect_to root_path
            else
              flash[:danger] = "Password not updated"
              render :edit
            end
        end
        end
    end

    private
    def authorize! 
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, User)
    end
    
end

