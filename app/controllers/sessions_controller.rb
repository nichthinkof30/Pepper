class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to root_url, notice: "#{current_user.name} is already signed in. Not you? Click 'Sign Out.'"
    end
  end

  def create
    puts params.inspect
    puts "888888888888888888888888"
    user = User.find_by_email(params[:email])
    puts User.all.inspect

    puts user.inspect
    puts "yyy"
    puts User.authenticate(params[:email], params[:password])

    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}."
      redirect_to(session[:intended_url] || user)
      session[:intended_url] = nil
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You're signed out."
  end

end