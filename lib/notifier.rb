require 'notifyuser'
require 'mail'

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