class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  # def create
  #   puts "====================got it !!!!!!============================="
  #   respond_to do |format|
  #     if @user = login(params[:email],params[:password])
  #       format.html { redirect_back_or_to(root_path, :notice => 'Login successful.') }
  #       format.xml { render :xml => @user, :status => :created, :location => @user }
  #     else
  #       format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
  #       format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end


  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Logged in"
    else
      user = User.authenticate_regardless_of_activation_state params[:email], params[:password]
      if user && user.activation_state == 'pending'
        auto_login(user)
        puts "i got here  :)============================================="
        redirect_back_or_to root_url, :notice => "Logged in. But, check ur email address to activate ur account."
      else
        flash.now.alert = "Email or password was invalid"
        render :new
      end
    end
  end






    
  def destroy
    logout
    redirect_to(root_path, :notice => 'Logged out!')
  end
end
