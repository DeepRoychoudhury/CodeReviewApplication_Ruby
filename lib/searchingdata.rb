#Template Design Pattern
module SearchingData
	class SearchBuilder

		def self.build_search(user,search)			
			get_searchdata(search)
			find_user(user)
			find_project
			find_note
			find_projectreview
			find_result
			searchdata
			find_linkstodata
		end

private 
		def self.get_searchdata(search)
			@datas=search.split(" ")
			puts "***************************************************************"
			puts @datas
			puts "**************************************************************"	
			puts "Inside superclass getsearch"
		end

		def self.find_user(user)			
  			@user=User.find(user)
		end

		def self.find_project			
  			@projects=Project.all.where(:user_id => @user.id)
		end

		def self.find_note
			@notes =""
			@projects.each do |project|
  				@note=Note.all.where(:project_id => project.id)
  				if !@note.empty?  				
  					@notes = @notes.to_s+@note.ids.to_s+project.id.to_s+" " 
  				end
  			end 
		end

		def self.find_projectreview
			@projectreviews=""
			@projects.each do |project|
  				@prj_reviews=PrjReview.all.where(:project_id => project.id)
  				if !@prj_reviews.empty?
	  				@prj_reviews.each do |prj_review|  	
	  					@projectreviews=@projectreviews.to_s+prj_review.id.to_s+project.id.to_s+" "
	  				end
  				end	
  			end
		end

		def self.find_result
			@allresults=""
			@projects.each do |project|
  				@results=Result.all.where(:project_id => project.id)
  				if !@results.empty?
	  				@results.each do |resul|	
	  					if(resul.id.to_s==project.id.to_s)
	  						@allresults=@allresults.to_s+resul.id.to_s+"same"+project.id.to_s+" "
	  					else
	  					@allresults=@allresults.to_s+resul.id.to_s+project.id.to_s+" "
	  				end
		  			end
		  		end
  			end
		end

		def self.searchdata
			@projectfindings=""			
			@notefindings=""
			@reviewfindings=""
			@resultfindings=""
			@datas.each do |data|
				@projects.each do |project|	
					if project.ProjectName.downcase.to_s.include? data
						@projectfindings=@projectfindings.to_s+"Project"+project.id.to_s
					end					
				end

				  @notes=@notes.split(" ")
				  @projects.each do |project|		
					  if project.ProjectName.downcase.to_s.include? data		
					 	 @notes.each do |note|
					 	 		if note.to_s.include? project.id.to_s
					 				notesplitted=note.split(project.id.to_s)
					 	 			@notefindings=@notefindings.to_s+"Note"+notesplitted.to_s
					 	 		end
					 	 end
					  end
				  end
			end
			
					 	 	binding.pry
				 	@projectreviews=@projectreviews.split(" ")
					@datas.each do |data|
					 @projects.each do |project|
						  if project.ProjectName.downcase.to_s.include? data
						    @projectreviews.each do |projectreview|
						  	if projectreview.to_s.include? project.id.to_s
						  		projectreviewsplitted=projectreview.split(project.id.to_s)
						  		@reviewfindings=@reviewfindings.to_s+"ProjectReview"+projectreviewsplitted.to_s
						  	end
						  end
						end
					end
				end	

				@allresults=@allresults.split(" ")
				@datas.each do |data|
				 @projects.each do |project|
					  if project.ProjectName.downcase.to_s.include? data
					  @allresults.each do |res|
					  	if res.to_s.include? project.id.to_s
						  		if (res.to_s.include? 'same')
						  		resultsplitted=res.split('same')
						  		resultsplitted=resultsplitted[1]
						  		else	
						  		resultsplitted=res.split(project.id.to_s)
						  		end
					  		@resultfindings=@resultfindings.to_s+"Result"+resultsplitted.to_s
					  	end
					  end
					end
				end
				
			end
			puts "Superclass searchdata called"
		end

		def self.find_linkstodata
   				@listarray=[]
				if !@projectfindings.empty?
					@projectfindings=@projectfindings.split("Project")					
					@projectfindings.each do |finding|
						if !finding.empty? 	
							@listarray << Project.find(finding)
						end
					end
					puts @listarray		
				end	
					
				if !@notefindings.empty?
					puts "Inside Note Linkstodata from super class"
					@notefindings=@notefindings.split("Note")
					@notefindings.each do |finding|		
						if !finding.empty? 	
							@listarray << Note.find(finding.scan(/\d+/).map(&:to_i))
						end
					end
				end

				if !@reviewfindings.empty?
					@reviewfindings=@reviewfindings.split("ProjectReview")
					@reviewfindings.each do |finding|		
						if !finding.empty? 
							@listarray << PrjReview.find(finding.scan(/\d+/).map(&:to_i))
						end
					end
				end

				if !@resultfindings.empty?
					@resultfindings=@resultfindings.split("Result")
					@resultfindings.each do |finding|
						if !finding.empty? 	
							@listarray << Result.find(finding.scan(/\d+/).map(&:to_i))
						end
					end
				end	
				return @listarray
		end
	end

	class SearchNote < SearchBuilder
		def self.searchdata							
			@notefindings=""
			@notes=@notes.split(" ")			
			@datas.each do |data|
				  @projects.each do |project|		
					  if data.include? project.ProjectName.downcase.to_s		
					 	 @notes.each do |note|
					 	 		if note.to_s.include? project.id.to_s
					 				notesplitted=note.split(project.id.to_s)
					 	 			@notefindings=@notefindings.to_s+"Note"+notesplitted.to_s
					 	 		end
					 	 end
					  end
				  end
			end
		end

		def self.find_linkstodata
			@listarray=[]
			if !@notefindings.empty?
					puts "Inside Nore Linkstodata from super class"
					@notefindings=@notefindings.split("Note")
					@notefindings.each do |finding|		
						if !finding.empty? 
							@listarray << Note.find(finding.scan(/\d+/).map(&:to_i))
						end
					end
			end
			return @listarray
		end
	end

	class SearchProject < SearchBuilder
		def self.searchdata		
			@projectfindings=""
			@datas.each do |data|
				@projects.each do |project|	
					if project.ProjectName.downcase.to_s.include? data
						@projectfindings=@projectfindings.to_s+"Project"+project.id.to_s
					end					
				end
			end
			puts "SearchProject(Subclass) searchdata called"
		end

		def self.find_linkstodata
			@listarray=[]
			if !@projectfindings.empty?
			@projectfindings=@projectfindings.split("Project")					
					@projectfindings.each do |finding|
						if !finding.empty? 	
							@listarray << Project.find(finding)
						end
					end
			end
			puts "Inside SearchProject subclass"
			return @listarray
		end

	end

	class SearchReview < SearchBuilder
		def self.searchdata	
			@projectreviews=@projectreviews.split(" ")
			@datas.each do |data|
				 @projects.each do |project|
					  if data.include? project.ProjectName.downcase.to_s
					  @projectreviews.each do |projectreview|
					  	if projectreview.to_s.include? project.id.to_s
					  		projectreviewsplitted=projectreview.split(project.id.to_s)
					  		@reviewfindings=@reviewfindings.to_s+"ProjectReview"+projectreviewsplitted.to_s
					  	end
					  end
					end
				end
			end			
			puts "SearchProjectReview(Subclass) searchdata called"
		end

		def self.find_linkstodata
			@listarray=[]
			if !@reviewfindings.empty?
					@reviewfindings=@reviewfindings.split("ProjectReview")
					@reviewfindings.each do |finding|		
						if !finding.empty? 	
							@listarray << PrjReview.find(finding.scan(/\d+/).map(&:to_i))
						end
					end
				end				
			puts "Inside SearchReview subclass"
			return @listarray
		end

	end

	class SearchResult < SearchBuilder
		def self.searchdata		
			@allresults=@allresults.split(" ")
				@datas.each do |data|
				 @projects.each do |project|
					  if data.include? project.ProjectName.downcase.to_s
					  @allresults.each do |res|
					  	if res.to_s.include? project.id.to_s
						  		if (res.to_s.include? 'same')
						  		resultsplitted=res.split('same')
						  		resultsplitted=resultsplitted[1]
						  		else	
						  		resultsplitted=res.split(project.id.to_s)
						  		end
					  		@resultfindings=@resultfindings.to_s+"Result"+resultsplitted.to_s
					  	end
					  end
					end
				end
			end
			puts "SearchResult(Subclass) searchdata called"
		end

		def self.find_linkstodata
			@listarray=[]
			if !@resultfindings.empty?
					@resultfindings=@resultfindings.split("Result")
					@resultfindings.each do |finding|		
						if !finding.empty? 	
							@listarray << Result.find(finding.scan(/\d+/).map(&:to_i))
						end
					end
				end				
			puts "Inside SearchResult subclass"
			return @listarray
		end

	end

end