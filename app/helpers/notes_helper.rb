module NotesHelper
	def findNotes(project)
		@project=Project.find(project)
		@note=Note.all.where(project_id: @project.id)
		puts @note
		
		return @note
	end	
end
