#gem file for sending mail with observer design pattern
require 'subject'
require 'notifyuser'
require 'mail'

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


class NotifyUser
  include Subject
  attr_reader :id, :notify, :user
  attr_accessor :notepad

  def initialize( id,notepad,notify,user )
    super()
    @user=user
    @id = id
    @notepad = notepad
    @notify = notify    
  end  


  def notepad=(new_notepad)    
    @notepad = new_notepad
    notify_observers(@user)
  end

end


class Notifier         
	def initialize(notifyuser)    
		notifyuser.add_observer(self)
	end

	def update(notifyuser,user)       
	begin
	# callback for observer	
		@notifyuser=notifyuser
		@user=user
		puts " Notifyuser #{notifyuser.id} has a change in notepad:  #{notifyuser.notepad}\n"
		NotifyuserMailer.send_email(@user,@notifyuser).deliver_now
	rescue Exception => e
		puts ("Exception Found : "+e.to_s)
	end
	end
end