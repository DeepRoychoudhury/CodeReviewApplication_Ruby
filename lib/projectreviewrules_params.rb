#Strategy design pattern
module Projectreviewrules_params
	class Finduserproject
		def self.find_params(userdetails)
			@projects=userdetails.projects
			return @projects
		end
	end

	class Finduser
		def self.find_params(userdetails)
			@user=User.find(userdetails)
			return @user
		end
	end

	class Findcustomreviewrules
		def self.find_params(userdetails)
			@customreviewrules=userdetails.customreviewrules
			return @customreviewrules
		end
	end

	class Findprojreviewsfromuser
		def self.find_params(userdetails)
			@projects=userdetails.projects
		    x=0
		    query=""
			    @projects.each do |project|
			      if x==0
			        query="select * from prj_reviews where project_id="+project.id.to_s
			      else
			        query=query+" OR project_id="+project.id.to_s
			      end    
			      x=x+1
			    end
		    puts query
		    @prjreviewsh=PrjReview.find_by_sql(query)
		    
			end
		end

		class Findresultsfromprojects
        def self.find_params(projectdetails)
            @projects=projectdetails
            x=0
            query=""
                @projects.each do |project|
                  if x==0
                    query="select * from results where project_id="+project.id.to_s
                  else
                    query=query+" OR project_id="+project.id.to_s
                  end  
                  x=x+1
                end
            puts query
            @prjresults=Result.find_by_sql(query)
          
            end
        end
end