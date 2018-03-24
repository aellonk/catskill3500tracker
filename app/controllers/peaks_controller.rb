class PeakController < ApplicationController
	get '/peaks' do
		if logged_in?
	      @peaks = current_user.peaks
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
	    if params[:name] == "" || params[:elevation] == "" || params[:date_hiked] == ""
	      redirect to "/peaks/new"
	    else
	    	case params[:name]
	    	when "Balsam"
	    		params[:elevation] = 3600
			when "Balsam Cap"
	    		params[:elevation] = 3623
	    	when "Balsam Lake"
	    		params[:elevation] = 3723
	    	when "Bearpen"
	    		params[:elevation] = 3600
	    	when "Big Indian"
	    		params[:elevation] = 3700
	    	when "Black Dome"
	    		params[:elevation] = 3980
	    	when "Blackhead"
	    		params[:elevation] = 3940
	    	when "Cornell"
	    		params[:elevation] = 3860
	    	when "Doubletop"
	    		params[:elevation] = 3860
	    	when "Eagle"
	    		params[:elevation] = 3600
	    	when "Fir"
	    		params[:elevation] = 3620
	    	when "Friday"
	    		params[:elevation] = 3694
	    	when "Graham"
	    		params[:elevation] = 3868
	    	when "Halcott"
	    		params[:elevation] = 3537
	    	when "Hunter"
	    		params[:elevation] = 4040
	    	when "Indian Head"
	    		params[:elevation] = 3573
	    	when "Kaaterskill High Peak"
	    		params[:elevation] = 3655
	    	when "Lone"
	    		params[:elevation] = 3721
	    	when "North Dome"
	    		params[:elevation] = 3610
	    	when "Panther"
	    		params[:elevation] = 3720
	    	when "Peekamoose"
	    		params[:elevation] = 3843
	    	when "Plateau"
	    		params[:elevation] = 3840
	    	when "Rocky"
	    		params[:elevation] = 3508
	    	when "Rusk"
	    		params[:elevation] = 3680
	    	when "Southwest Hunter"
	    		params[:elevation] = 3740
	    	when "Sherrill"
	    		params[:elevation] = 3540
	    	when "Slide"
	    		params[:elevation] = 4180
	    	when "Sugarloaf"
	    		params[:elevation] = 3880
	    	when "Table"
	    		params[:elevation] = 3847
	    	when "Thomas Cole"
	    		params[:elevation] = 3940
	    	when "Twin"
	    		params[:elevation] = 3640
	    	when "Vly"
	    		params[:elevation] = 3529
	    	when "Westkill"
	    		params[:elevation] = 3880
	    	when "Windham High Peak"
	    		params[:elevation] = 3524
	    	when "Wittenberg"
	    		params[:elevation] = 3780
	    	end
	    	
	      @peak = current_user.peaks.create(name: params[:name], elevation: params[:elevation], date_hiked: params[:date_hiked], remarks: params[:remarks])
	      redirect to "/peaks/#{@peak.id}"
	    end
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
		if params[:name] == "" || params[:elevation] == "" || params[:date_hiked] == ""
			redirect to "/peaks/#{params[:id]}/edit"
		else
			@peak = Peak.find_by_id(params[:id])
			@peak.name = params[:name]
			@peak.elevation = params[:elevation]
			@peak.date_hiked = params[:date_hiked]
			@peak.remarks = params[:remarks]
			@peak.save
			flash[:alert] = "Your peak was successfully updated."
			redirect to "/peaks/#{@peak.id}"
		end
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