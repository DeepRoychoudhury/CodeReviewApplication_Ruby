module ProjectsHelper
	def findNotes(project)		
		#@project=Project.find(params[])
		@note=Note.all.where(:project_id => project)
	end
end
