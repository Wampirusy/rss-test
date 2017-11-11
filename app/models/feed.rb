class Feed < ApplicationRecord
	has_many :articles, dependent: :destroy
	
	def last_articles(limit = nil, offset = 0)
		articles.order({
				:published => :desc,
				:created_at => :desc
			}).limit(limit).offset(offset)
	end
	
	def last_article
		articles.order({:published => :desc}).first
	end
end
