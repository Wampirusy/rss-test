class FeedController < ActionController::Base
	ITEMS_PER_PAGE = 10
	
	def add		
		if params[:url].nil?
			raise "incorrect request"
		else
			if !feed = Feed.find_by_url(params[:url])
				feed = Feed.new({:url => params[:url]})
				feed.save
			end
			
			FeedService.scrape(feed)
			
			render :json => feed
		end
	end
	
	def get
		if feed = Feed.find(params[:id])
			render :json => feed.last_articles(limit, offset)
		else
			raise 'feed not found'
		end
	end
	
	protected
	def limit
		ITEMS_PER_PAGE
	end
	
	def offset
		ITEMS_PER_PAGE * params[:page].to_i
	end
end
