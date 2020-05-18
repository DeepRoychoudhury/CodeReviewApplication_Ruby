class NotifyuserMailer < ApplicationMailer
	def self.send_email(user,note)
		@user=User.find(user)
		@notepad=note
		@note=Note.find(@notepad.id)
		@project=Project.find(@note.project_id)
		(ActionMailer::Base).mail(from: 'x19109130@student.ncirl.ie', to: @user.email, subject: "Updated notes for #{@project.ProjectName}", body: "Notes for #{@project.ProjectName} \n #{@notepad.notepad}")
	end
end