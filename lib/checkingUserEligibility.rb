#Adapter Desiign Pattern
module Checkinguserligibility
   class Usercheck
      def self.check_user_page(request)  
         if request.include? "localhost:3000"
            page=request.split("http://localhost:3000")
         elsif request.include? "codereviewapplication.herokuapp.com"
            page=request.split("https://codereviewapplication.herokuapp.com")
	 elsif request.include? "limitless-fortress-33407.herokuapp.com"
            page=request.split("https://limitless-fortress-33407.herokuapp.com")
      else
         page=request
      end
      return page           
      end
   end

   class FindPages
      def self.find_rolebased_pages(userid)
               @pages = PageMaster.all.joins('INNER JOIN role_pages ON page_masters.id = role_pages.page_master_id INNER JOIN user_roles ON role_pages.role_master_id = user_roles.role_master_id Where user_roles.user_id = '+ userid.to_s )   
          @pages.map {|page| [page.pagelink, page.pagename]}
          return @pages
      end
   end   

   class UserVerification
      def self.find_user_verification(userid,path)
         @userparameters=[]
         mode=nil
         userpermission="No"
         project_id=nil
         note_id=nil
         review_id=nil
         @user=User.find(userid)
         @path=path.split("/")
         if (@path.include? "users")
            @path.each do |path|
               if path.to_s.include? @user.id.to_s
                  userpermission="Yes"
               end   
            end   
         else      
               @path.each do |p|
               if mode!=nil
                  if mode.include? "project"
                     project_id=p
                     @userparameters << project_id+"pid"
                  elsif mode.include? "note"
                     note_id=p  
                     @userparameters << note_id+"nid" 
                  elsif mode.include? "review"
                     review_id=p  
                     @userparameters << review_id+"rid" 
                  elsif mode.include? "result"
                     review_id=p  
                     @userparameters << review_id+"resid"

                  end  
             end   
               mode=p
          end

         @userparameters.each do |userparameter| 
         if (userparameter.include? "pid") || (userparameter.include? "nid") || (userparameter.include? "rid") || (userparameter.include? "resid")  
            if (userparameter.include? "pid")
            userparameter=userparameter.split("pid")
            elsif (userparameter.include? "nid")
               userparameter=userparameter.split("nid")
            elsif (userparameter.include? "rid")               
               userparameter=userparameter.split("rid")
            elsif (userparameter.include? "resid")               
               userparameter=userparameter.split("resid")                  
            end

            @projects=@user.projects
               if(!@projects.empty?)
                  @projects.each do |proj| 
                     @proj=proj           
                     @not=Note.all.where(:project_id => @proj.id)
                     @prjrev=PrjReview.all.where(:project_id => @proj.id)
                     @resul=Result.all.where(:project_id => @proj.id)  
                     if (userparameter.include? @proj.id.to_s) 
                        userpermission="Yes"
                     elsif !@not.empty?
                        @not.each do |n|
                           if (userparameter.include? n.id.to_s)
                             userpermission="Yes"
                           end  
                        end
                     elsif (!@prjrev.empty?)
                        @prjrev.each do |pr|
                           @pr=pr
                           if (userparameter.include? @pr.id.to_s)
                               userpermission="Yes"
                           end
                        end  
                     elsif (!@resul.empty?)
                        @resul.each do |r|
                           @r=r
                           if (userparameter.include? @r.id.to_s)
                               userpermission="Yes"
                           end
                        end 
                     end                  
                  end
               end
            end
         end
         return userpermission
      end
   end
   end   
	
   class Findusereligibility
      def self.find_pages(page,pagelist)
      		eligibility="false"
      		pagelist.each do |pa|
               if (page=='/') || (page.to_s.include? 'projreview') 
                  eligibility="true"
      			elsif (page.to_s.include? pa.pagelink) && (pa.pagelink!='/')
      				puts "You are eligible to use the page"	
      				eligibility="true"		
      			end	
      		end	
      		return eligibility
      end
   end


end