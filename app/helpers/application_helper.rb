module ApplicationHelper
	def format_menus(current_userid)
			@page_list = PageMaster.all.joins('INNER JOIN role_pages ON page_masters.id = role_pages.page_master_id INNER JOIN user_roles ON role_pages.role_master_id = user_roles.role_master_id Where user_roles.user_id = '+ current_userid.to_s )   
    @page_list.map {|arr| [arr.pagelink, arr.pagename]}
    
    end

   
	
end

