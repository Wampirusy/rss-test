class Article < ApplicationRecord
  belongs_to :feed
	
	def Article.new_from_rss(feed, item)
		Article.new({
			:title => item.title,
			:url => item.link,
			:content => item.description,
			:published => item.pubDate,
			:feed => feed,
		})
	end
end
