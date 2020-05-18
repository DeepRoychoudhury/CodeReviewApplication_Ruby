require 'userEligibilityAdapter'
class ApplicationController < ActionController::Base
	  before_action :authenticate_user!, :user_access_type
	  protect_from_forgery prepend: true
	  
	  private
		    def user_access_type		   
		    	   signin=user_signed_in? 			    	   
			       if (user_signed_in?) && (!request.path_info.to_s.include? "sign_out")
			       @check=(UserEligibilityAdapter::CheckUser).isusereligible(signin,request.path_info,current_user.id)
				       if (@check=="No") && ((request.path_info.to_s!="/")&&((request.path_info).split("/").length!=2))
				       	redirect_to root_path
				       	elsif (@check=="No") && ((request.path_info.to_s!="/")&&(((request.path_info).split("/").include?"user_roles") || ((request.path_info).split("/").include?"role_pages") || ((request.path_info).split("/").include?"page_master") || ((request.path_info).split("/").include?"role_master")))
				       	redirect_to root_path
				       end
			   	   end
		    end
end
