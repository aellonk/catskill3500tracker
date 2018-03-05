class UserController < ApplicationController

	get '/users/:slug' do
	    @user = User.find_by_slug(params[:slug])
	    erb :'users/show'
  	end

	get '/signup' do
	    if !logged_in?
	      erb :'users/signup'
	    else
	      redirect to '/peaks'
	    end
  	end

  	post '/signup' do
	  	if params[:firstname] == "" || params[:lastname] == "" || params[:email] == "" || params[:username] == "" ||  params[:password] == ""
	      redirect to '/signup'
	    else
	    	@user = User.new(:firstname => params[:firstname], :lastname => params[:lastname], :email => params[:email], :username => params[:username], :password => params[:password])
		    @user.save
		    session[:user_id] = @user.id
		    redirect to '/peaks'
	    end
  	end

  	get '/login' do
		if !logged_in?
	      erb :'users/login'
		else
		  redirect to '/peaks'
		end
  	end

  	post '/login' do
	    user = User.find_by(:username => params[:username])
	    if user && user.authenticate(params[:password])
	      session[:user_id] =  user.id
	      redirect "/peaks"
	    else
	      redirect to '/signup'
	    end
  	end

end