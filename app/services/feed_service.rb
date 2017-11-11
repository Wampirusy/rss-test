module FeedService
	def self.scrape (feed)
		require 'rss'
		require 'open-uri'
		
		last_scraped = feed.last_article
				
		open(feed.url) do |rss|
			rss_feed = RSS::Parser.parse(rss)
			
			rss_feed.items.each do |item|				
				return if is_allready_scraped?(last_scraped, item)
				
				Article.new_from_rss(feed, item).save 				
			end
		end
	end
	
	protected
	def self.is_allready_scraped?(article, item)
		return false if article.nil? 
		
		#todo: fix for maultitude articles with the same pubDate
		return item.pubDate < article.published || item.pubDate == article.published && item.title == article.title
	end
end
