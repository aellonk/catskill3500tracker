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
end