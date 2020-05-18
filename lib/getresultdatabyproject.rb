module Getresultdatabyproject
class GetResultDataByPrj
   def self.find_resultdata(project_id, typeoffile)
      query="select * from results where project_id=" + project_id.to_s + " and \"Type_Of_File\" =" + "'" + typeoffile.to_s + "'"
      
      @result_data=Result.find_by_sql(query) 	
   end
end
end