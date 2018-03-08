class PeakController < ApplicationController

	get '/peaks' do
		if logged_in?
	      @peaks = Peak.all
	      erb :'peaks/peaks'
	    else
	      redirect to '/login'
	    end
	end

	get '/peaks/new' do
		if logged_in?
			@peaks = Peak.all
      		erb :'/peaks/add_peak'
    	else
      		redirect to '/login'
    	end
	end

	post '/peaks' do
	    if params[:name] == "" || params[:elevation] == "" || params[:date_hiked] == ""
	      redirect to "/peaks/new"
	    else
	      @peaks = current_user.peaks.create(name: params[:name], elevation: params[:elevation], date_hiked: params[:date_hiked], remarks: params[:remarks])
	    end
	end

	get '/peaks/:id' do
		if logged_in?
			@peak = Peak.find_by_id(params[:id])
			erb :'peaks/show_peak'
		else
      		redirect to '/login'
		end
	end


end