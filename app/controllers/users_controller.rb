class UserController < ApplicationController

	get '/users/:slug' do
	    @user = User.find_by_slug(params[:slug])
	    erb :'users/show'
  	end

	get '/signup' do
	    if !logged_in?
	      erb :'users/signup'
	    else
	      redirect to '/'
	    end
  	end

  	post '/signup' do
	  	@user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
	    	if @user.valid?
		    @user.save
		    session[:user_id] = @user.id
		    redirect to '/peaks'
			elsif !@user.valid?
				flash[:alert] = "Email Address and/or Username Already Taken."
				erb :'users/signup'
			end
  	end

  	get '/login' do
		if !logged_in?
	      erb :'users/login'
		else
		  redirect to '/'
		end
  	end

  	post '/login' do
	    user = User.find_by(:username => params[:username])
	    if user && user.authenticate(params[:password])
	      session[:user_id] =  user.id
	      redirect to "/peaks"
	    else
	      flash[:alert] = "Wrong username and/or password."
	      erb :'users/login'
	    end
  	end

  	get '/logout' do
  		if logged_in?
  			session.destroy
  			redirect to '/login'
  		else
  			redirect to '/'
  		end
  	end

end