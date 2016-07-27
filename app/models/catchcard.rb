class Catchcard < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  belongs_to :fish

  	def self.period_count_array(from = (Date.today-1.year).beginning_of_day,to = Date.today.end_of_day)
  		where(created_at: from..to).group('date(created_at)').count
	end



end
