class PeakController < ApplicationController
	get '/peaks' do
		if logged_in?
	      @peaks = current_user.peaks
	      @users = User.all
	      erb :'peaks/all_peaks'
	    else
	      flash[:alert] = "You must be logged in."
	      redirect to "/login"
	    end
	end

	get '/peaks/new' do
		if logged_in?
			@peaks = current_user.peaks
      		erb :'/peaks/add_peak'
    	else
    		flash[:alert] = "You must be logged in."
      		redirect to "/login"
    	end
	end

	post '/peaks' do
	    	peak = Peak.find_by(name: params[:name])
	    	params[:elevation] = peak.elevation
	      @peak = current_user.peaks.create(name: params[:name], elevation: params[:elevation], date_hiked: params[:date_hiked], remarks: params[:remarks])
	      redirect to "/peaks/#{@peak.id}"
	end

	get '/peaks/:id' do
		if logged_in?
			@peak = Peak.find_by_id(params[:id])
			erb :'peaks/show_peak'
		else
			flash[:alert] = "You must be logged in."
      		redirect to "/login"
		end
	end

	get '/peaks/:id/edit' do
		if logged_in?
			@peak = Peak.find_by_id(params[:id])
			if @peak.user_id == current_user.id
				erb :'peaks/edit_peak'
			else
				flash[:alert] = "You must be the owner of the peak to edit."
				redirect to "/peaks"
			end
		else
			flash[:alert] = "You must be logged in."
			redirect to "/login"
		end
	end


	patch '/peaks/:id' do
	    	peak = Peak.find_by(name: params[:name])
	    	params[:elevation] = peak.elevation
			@peak = Peak.find_by_id(params[:id])
			@peak.name = params[:name]
			@peak.elevation = params[:elevation]
			@peak.date_hiked = params[:date_hiked]
			@peak.remarks = params[:remarks]
			@peak.save
			flash[:alert] = "Your peak was successfully updated."
			redirect to "/peaks/#{@peak.id}"
	end

	delete '/peaks/:id/delete' do
		if logged_in?
			@peak = Peak.find_by_id(params[:id])
			if @peak.user_id == current_user.id
				@peak.delete
				redirect to '/peaks'
			else
				redirect to '/peaks'
			end
		else
			flash[:alert] = "You must be logged in."
			redirect to 'login'
		end
	end


end