require 'subject'

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