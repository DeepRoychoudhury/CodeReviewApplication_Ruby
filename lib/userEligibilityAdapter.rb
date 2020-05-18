#Adapter pattern design pattern
require 'checkingUserEligibility'

module UserEligibilityAdapter
	class CheckUser
		def self.isusereligible(user_signed_in,request,user)
			@check="No"
			if user_signed_in==true		  	
			       	begin
			       	  if !request.include? "sign_out"
			       	  	@userspecific="No"
				       	 page=(Checkinguserligibility::Usercheck).check_user_page(request)
				           @page_list=(Checkinguserligibility::FindPages).find_rolebased_pages(user)    
				           eligibility=(Checkinguserligibility::Findusereligibility).find_pages(page,@page_list)
					           if (eligibility == "true")
						           if((request.include? "project") || (request.include? "note") || 
						           	(request.include? "review") || (request.include? "result")) && 
						           	((!request.include? "new") && (!request.include? "edit")) && ((request.split("/")).length > 2) 						         
							           @userspecific=(Checkinguserligibility::UserVerification).find_user_verification(user,request)
							             if (@userspecific=="No")
								            puts "Redirecting to root"
								            @check="No"
								        else
								        	@check="Yes"
							    	   	end	
							    	 elsif(request.include?"project")&&(request.include?"new")
							    	 @check="Yes"  	
							    	elsif(request.include?"review")&&(request.include?"new")
							    	 @check="Yes"
							    	elsif(request.include?"result") && (request.include?"new")
							    		@check="Yes"
							    	elsif(request.include?"user_roles") || (request.include?"role_masters") || (request.include?"role_pages") || (request.include?"page_master")
							    		@check="Yes"
							    	elsif(request.include?"note")
							    	@check="Yes"
							    	elsif(request.include?"search")
							    	@check="Yes"		
							    	end	     	
						       else
								  puts "Redirecting to root"
								  @check="No"					     	  
					       	end
				       	end
			       	 rescue Exception => e
			       	 puts ("Found Exception : " +e.to_s )
			       	end
		    	end
		    	return @check
		end
	end
end