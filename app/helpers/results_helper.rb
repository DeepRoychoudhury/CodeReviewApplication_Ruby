require 'rubygems'
require 'zip'
require 'CRA_logic_deep'
require 'CRA_logic_shraddha'
module ResultsHelper

	def findErrors(project_id,file_type)		
		@path_list = getFolderErrorList(project_id,file_type)
	end

	def getFolderErrorList(project_id,file_type)
		@project = Project.find(project_id)
        @myPath = @project.Path

        Result.select do |result|
     		 		result.Project_id == project_id
			 		result.destroy
		end
		Zip::File.open(@myPath.file.path) do |zip_file|
  			# Handle entries one by one
  			@errrList =""
  			zip_file.each do |entry|
  				
  			  if entry.file? 
  			  	content = entry.get_input_stream.read
				@chkController = "#{entry.name}  ".include? "Controller"
				@chkModel = "#{entry.name}  ".include? "Model"
				@chkView= "#{entry.name}  ".include? "View"
				@file_content= entry.get_input_stream.read
				
				@file_destination = "/" + entry.name.split('/')[entry.name.split('/').count - 2]  + "/" + entry.name.split('/')[entry.name.split('/').count - 1] 
				# binding.pry
				if @chkController == true	
						@getFinalErrorList = getErrorsFromController(project_id,@file_content)		
			    elsif @chkModel == true	
			   			@getFinalErrorList = getErrorsFromModel(project_id,@file_content)		
			    elsif @chkView == true	
			   			@getFinalErrorList = getErrorsFromView(project_id,@file_content)		
			   end	
  			  else
  			    puts "#{entry.name} is something unknown, oops!"
  			  end
  			end
  		end
  		@p = @getFinalErrorList
	end


	def getErrorsFromController(project_id,file_content)
        @NumberofLines = 0
		@NumberofMethods = 0
		@NumberofComments = 0
		@FirstLetterOfMethodName = ""
		@MultipleDef =""
		@chkMethodCall =""
		@methodNotDefined = ""
		@NumberInMethod =""
		@CheckEncodingStatus = ""
		@CheckEncodingStatus = @CheckEncodingStatus + " " + @file_destination + " - " + (CRA_logic_shraddha::CheckEncoding).getData(file_content,nil)  + "; "
		@ChkCharCountPerLine = ""
		@resCheckDoubleQuotes =""
	    @resSpaceAfterLineEnd =""
	    @resChkQueriesInFile = ""
	    @ParamCountInMethod = 0
		 #Check coding specific rules
		 
# puts file_destination ="/home/shraddha2977/CRA/uploads/project/Path/29/bad_proj.zip/bad_proj/Controller/showme.rb"
			@file_content.each_line do |line|
			# File.foreach(file_destination) do |line|
				# @errrList = @errrList +  " Error 1"
			  	 @NumberofLines =  (CRA_logic_deep::NoOfLines).getData(@NumberofLines,nil)
			  	 @resCharPerLine =""			  	 	
					
			  	 #binding.pry
 				 @chkMethodCall =  line.match(/\..*\(/) #get method called in one line
 				 @ChkCharCountPerLine = (CRA_logic_shraddha::CharCountPerLine).getData(line,nil) 				 
 				 @spaceAfterLineEnd = (CRA_logic_shraddha::SpaceAfterLineEnd).getData(line,nil) 
                 @ChkQueriesInFile = (CRA_logic_shraddha::QueriesInFile).getData(line,nil) 
                 if @ChkQueriesInFile != ""
                 	@resChkQueriesInFile = @resChkQueriesInFile +  "\n Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - sql query words detect presence of sql queries in a file; \n"
                 end
 				 if !(((CRA_logic_deep::CountWord).getData(line,"\"")).to_i.even? )
 				 	@resCheckDoubleQuotes = @resCheckDoubleQuotes + "Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - has uneven double quotes;   "
 				 end
 				 if @spaceAfterLineEnd > 0
 				 	@resSpaceAfterLineEnd = @resSpaceAfterLineEnd + "Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - contains trailing spaces after line end;   "
 				 end
 				 if @ChkCharCountPerLine > 0
 				 	@resCharPerLine = @resCharPerLine + "Line number - " + @NumberofLines.to_s + " " +@file_destination+ " - " + line + " - contains more number of character than expected in a line;   "
 				 end
 				 if line.include? "#"
					@NumberofComments = @NumberofComments + (CRA_logic_deep::NumberofComments).getData(@NumberofComments,nil).to_i
 				 end
                 if line.include? "def"
                 	@ParamCountInMethod = (CRA_logic_shraddha::ParamCntInMethod).getData(@ParamCntInMethod,nil)
			  		@NumberofMethods =  (CRA_logic_deep::NoOfMethods).getData(@NumberofMethods,nil)
			  		@indexof_met = line.index("def")	+ 4 
			  		if((CRA_logic_deep::IsUpper).getData(line[@indexof_met],nil) != "") 
                    	@FirstLetterOfMethodName = @FirstLetterOfMethodName + "Line number - " + @NumberofLines.to_s + " " + @file_destination + " - " + line + " - contains invalid method name as first letter is capital" + "; " 
                    end
                    if(((CRA_logic_deep::CountWord).getData(line,"def")).to_i > 1)
                    	@MultipleDef = @MultipleDef + "Line number - " + @NumberofLines.to_s + " " +   @file_destination  + " - " + line + " - contains def keyword multiple times" + "; "  
                    end  
                    if (CRA_logic_shraddha::CheckNumPresent).getData(line,nil) 
                    	@NumberInMethod = @NumberInMethod + "Line number - " + @NumberofLines.to_s + " " + @file_destination  + " - " + line + " - contains number in method" + "; "  
                    end                   
			  	end 
			  	if @chkMethodCall.to_s != ""
			  		@chkMethodCall = (CRA_logic_deep::MethodCallCount).getData(@chkMethodCall,nil) 
			  		@chkFormat = defined? @chkMethodCall
			  		if @chkFormat == nil
			  			@methodNotDefined = @methodNotDefined + "Line number - " + @NumberofLines.to_s + " " +  @file_destination  + " - " + line + "Call to undefined method;  "
			  		end
			  	end
			 end 

	   #Check user specific rules
		@prjReviewArray = []
	    @prjReviewArray = PrjReview.select { |prjreview| prjreview.project_id == project_id}
        @prjReviewArray.each do |r_data|

         	 if Review.find(r_data.Review_id).FileType == "Controller" 
                 case Review.find(r_data.Review_id).ReviewName
                 when "Number of lines"
                 	if @NumberofLines > r_data.ReviewValue.to_i
                 		@NOL_Error = @file_destination  + " - " + " Number of lines in controller are greater than predefined criteria; "
                 		@errrList = @errrList + @NOL_Error
                 		 logErrorToDB(project_id,@file_destination ,"Controller",@file_destination,@NumberofLines,@NOL_Error)
                 	end

              	when "Number of methods"
                 	if @NumberofMethods > r_data.ReviewValue.to_i
                 		@NOM_Error = @file_destination + " - " + " Number of methods in controller are greater than predefined criteria; "
                 		@errrList = @errrList +  @NOM_Error 
                 		logErrorToDB(project_id, @file_destination ,"Controller",@file_destination,@NumberofMethods,@NOM_Error)
                 	end

                 when "Multiple_def_word"              	
                	 if !@MultipleDef.empty? and r_data.ReviewValue 
                		@errrList = @errrList +   @MultipleDef
                		logErrorToDB(project_id,@file_destination ,"Controller",@file_destination,@NumberofLines,@MultipleDef)
                	 end
                 
                when "CapitalizeFirstLetterOfMethod" 
                	if !@FirstLetterOfMethodName.empty? and r_data.ReviewValue 
                		@errrList = @errrList + @FirstLetterOfMethodName 
                		logErrorToDB(project_id,@file_destination ,"Controller",@file_destination,@NumberofLines,@FirstLetterOfMethodName)
                	end
                when "CheckUndefinedMethods"
                	if !@methodNotDefined.empty? and r_data.ReviewValue 
                		@errrList = @errrList + @methodNotDefined
                		logErrorToDB(project_id,@file_destination ,"Controller",@file_destination,@NumberofLines,@FirstLetterOfMethodName)
                	end 
                when "NumberInMethod"
                	if !@NumberInMethod.empty? and r_data.ReviewValue 
                		@errrList = @errrList + @NumberInMethod
                		logErrorToDB(project_id,@file_destination,"Controller",@file_destination,@NumberofLines,@NumberInMethod)
                	end
                when "CheckFileEncodeStatus"
                	if r_data.ReviewValue and !@CheckEncodingStatus.empty?
                		@errrList = @errrList + @file_destination +  @CheckEncodingStatus
                		logErrorToDB(project_id,@file_destination,"Controller",@file_destination,@NumberofLines,@CheckEncodingStatus)
                	end
                when "SetCharCountPerLine"
                	if @ChkCharCountPerLine > r_data.ReviewValue.to_i
            			@errrList = @errrList + @resCharPerLine
            			logErrorToDB(project_id,@file_destination,"Controller", @file_destination,@NumberofLines,@resCharPerLine)
                	end
            	when "CheckSpaceAfterLineEnd"
            		if @spaceAfterLineEnd > 0 and r_data.ReviewValue
            			@errrList = @errrList + @resSpaceAfterLineEnd
            			logErrorToDB(project_id,@file_destination,"Controller", @file_destination,@NumberofLines,@resSpaceAfterLineEnd)
            		end
            	when "CheckDoubleQuotes"
            		if !@resCheckDoubleQuotes.empty? and r_data.ReviewValue
            			@errrList = @errrList + @resCheckDoubleQuotes
            			logErrorToDB(project_id,@file_destination,"Controller", @file_destination,@NumberofLines,@resCheckDoubleQuotes)
            		end
            	when "QueriesPresentInFile"
            		if !@resChkQueriesInFile.empty? and r_data.ReviewValue
            			@errrList = @errrList + @resChkQueriesInFile
            			logErrorToDB(project_id,@file_destination,"Controller", @file_destination,@NumberofLines,@resChkQueriesInFile)
            		end
            	when "NumberofComments"
                 	if @NumberofComments > r_data.ReviewValue.to_i
                 		@NOCM_Error = @file_destination + " - Line number - " + @NumberofLines.to_s + " Number of comments in controller are greater than predefined criteria; "
                 		@errrList = @errrList +  @NOCM_Error 
                 		logErrorToDB(project_id, @file_destination ,"Controller",@file_destination,@NumberofLines,@NOCM_Error)
                 	end
        		when "ParameterCountInMethod"
                 	if @ParamCountInMethod > r_data.ReviewValue.to_i
                 		@NOPC_Error = @file_destination + " - Line number - " + @NumberofLines.to_s + " Number of parameters in methods of controller are greater than predefined criteria; "
                 		@errrList = @errrList +  @NOPC_Error 
                 		logErrorToDB(project_id, @file_destination ,"Controller",@file_destination,@NumberofLines,@NOPC_Error)
                 	end
        		end
         	      end           
            end
		@errrList 
	end

	def getErrorsFromModel(project_id,file_content)
		@errrList = ""
			File.foreach(file_content) do |line|
				@errrList = @errrList +  " Error 1"
			  				 
			 end 
		@errrList	 
	end
	
	def getErrorsFromView(project_id,file_content)
		@errrList = ""
			File.foreach(file_content) do |line|
				@errrList = @errrList +  " Error 1"
			  				 
			 end 
		@errrList	
	end

	def logErrorToDB(project_id,folder_name,fileoftype,file_destination,errorlinenum,errordescr)
		Result.create(:project_id => project_id, :Folder_Name => @file_destination,:Type_Of_File => fileoftype , :FileName => Project.find(project_id).Path.to_s ,:Error_Line_Number => errorlinenum,:Error_Description => errordescr)            
	end


end 
