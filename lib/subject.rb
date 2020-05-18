module Subject
	def initialize
		@observers=[]
	end

	def add_observer(observer)
		@observers << observer
	end

	def delete_observer(observer)
		@observers.delete(observer)
	end

	def notify_observers(user)
		@observers.each do |observer|			
			observer.update(self,user)
		end
	end
end