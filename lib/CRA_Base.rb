#Template design pattern

require 'CRA_logic_deep'
require 'CRA_logic_shraddha'
module CRA_base
	class CodeReviewBase
			def self.finding_Errors(project_id,file_content,errrList,file_destination)
				getError(project_id,file_content,errrList,file_destination)
			end

		def self.getError(project_id,file_content)
			puts "Base Class getError method called"
		end

		def self.logErrorToDB(project_id,folder_name,fileoftype,file_destination,errorlinenum,errordescr)
			# Result.create(:project_id => project_id, :Folder_Name => @file_destination,:Type_Of_File => fileoftype , :FileName => Project.find(project_id).Path.to_s ,:Error_Line_Number => errorlinenum,:Error_Description => errordescr)            
            inserts = []
            time = Time.now
            inserts.push "(#{project_id},'#{@file_destination}', '#{fileoftype}', '#{Project.find(project_id).Path.to_s }',#{errorlinenum}, '#{errordescr}' ,'#{time}','#{time}')"
            sql = "INSERT INTO results(project_id,\"Folder_Name\",\"Type_Of_File\",\"FileName\",\"Error_Line_Number\",\"Error_Description\",created_at,updated_at) VALUES #{inserts.join(", ")}"
            ActiveRecord::Base.connection.execute(sql) 
        end
	end

	class ErrorFromController < CodeReviewBase
		def self.getError(project_id,file_content,errrList,file_destination)
        if file_destination.split('/')[1].downcase == "controllers" 
			@errrList=errrList.to_s
			@NumberofLines = 0
		@NumberofMethods = 0
		@FirstLetterOfMethodName = ""
		@MultipleDef =""
		@chkMethodCall =""
		@methodNotDefined = ""
		@NumberInMethod =""
		@CheckEncodingStatus = ""
		@file_destination=file_destination
        @NumberofComments = 0
        @resChkQueriesInFile = ""
        @ParamCountInMethod = 0
		 begin
		@CheckEncodingStatus = @CheckEncodingStatus + " " + @file_destination + " - " + (CRA_logic_shraddha::CheckEncoding).getData(file_content,nil)  + "; "
		 @ChkCharCountPerLine = ""
		@resCheckDoubleQuotes =""
	    @resSpaceAfterLineEnd =""
			file_content.each_line do |line|
			  	 @NumberofLines =  (CRA_logic_deep::NoOfLines).getData(@NumberofLines,nil)
			  	 @resCharPerLine =""			  	 	
					
 				 @chkMethodCall =  line.match(/\..*\(/) #get method called in one line
 				 @ChkCharCountPerLine = (CRA_logic_shraddha::CharCountPerLine).getData(line,nil) 				 
 				 @spaceAfterLineEnd = (CRA_logic_shraddha::SpaceAfterLineEnd).getData(line,nil) 
                 @ChkQueriesInFile = (CRA_logic_shraddha::QueriesInFile).getData(line,nil) 

                 if @ChkQueriesInFile != ""
                    @resChkQueriesInFile = @resChkQueriesInFile +  "\n Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - sql query words detect presence of sql queries in a file; \n"
                 end                 
 				 if !(((CRA_logic_deep::CountWord).getData(line,"\"")).to_i.even? )
 				 	@resCheckDoubleQuotes = @resCheckDoubleQuotes + "Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - has uneven double quotes"
 				 end
 				 if @spaceAfterLineEnd > 0
 				 	@resSpaceAfterLineEnd = @resSpaceAfterLineEnd + "Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - contains trailing spaces after line end"
 				 end
 				 if @ChkCharCountPerLine > 0
 				 	@resCharPerLine = @resCharPerLine + "Line number - " + @NumberofLines.to_s + " " +@file_destination+ " - " + line + " - contains more number of character than expected in a line"
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
                    	@NumberInMethod = @NumberInMethod + "Line number - " + @NumberofLines.to_s + " " + @file_destination  + " - " + line + " - contains number in method name" + "; "  
                    end                   
			  	end 
			  	if @chkMethodCall.to_s != ""
			  		@chkMethodCall = (CRA_logic_deep::MethodCallCount).getData(@chkMethodCall,nil) 
			  		@chkFormat = defined? @chkMethodCall
			  		if @chkFormat == nil
			  			@methodNotDefined = @methodNotDefined + "Line number - " + @NumberofLines.to_s + " " +  @file_destination  + " - " + line + "Call to undefined method"
			  		end
			  	end
			 end 

	   #Check user specific rules
		@prjReviewArray = []
	    @prjReviewArray = PrjReview.select { |prjreview| prjreview.project_id == project_id}
        @prjReviewArray.each do |r_data|

         	 if Review.find(r_data.review_id).FileType == "Controller" 
                 case Review.find(r_data.review_id).ReviewName
                    #puts Review.find(r_data.review_id).ReviewName
                 when "Number of lines"
                 	if @NumberofLines > r_data.ReviewValue.to_i
                 		@NOL_Error = @file_destination  + " - " + " Number of lines in controller are greater than predefined criteria; "
                 		if @errrList != nil
                 		@errrList = @errrList + @NOL_Error
             			else
                 		@errrList = @NOL_Error
                 		end
                 		logErrorToDB(project_id,@file_destination ,"Controller",@file_destination,@NumberofLines,@NOL_Error)
                 	end

              	when "Number of methods"
                 	if @NumberofMethods > r_data.ReviewValue.to_i
                 		@NOM_Error = @file_destination + " - " + " Number of methods in controller are greater than predefined criteria; "
                 		if @errrList != nil
                 		@errrList = @errrList +  @NOM_Error 
                 		else
                 		@errrList = @NOM_Error
                 		end
                 		logErrorToDB(project_id, @file_destination ,"Controller",@file_destination,@NumberofMethods,@NOM_Error)
                 	end

                 when "Multiple_def_word"              	
                	 if !@MultipleDef.empty? and r_data.ReviewValue 
                		if @errrList != nil
                		@errrList = @errrList +   @MultipleDef
                		else
                		@errrList = @MultipleDef
                		end
                		logErrorToDB(project_id,@file_destination ,"Controller",@file_destination,@NumberofLines,@MultipleDef)
                	 end
                 
                when "CapitalizeFirstLetterOfMethod" 
                	if !@FirstLetterOfMethodName.empty? and r_data.ReviewValue 
                		if @errrList != nil
                		@errrList = @errrList + @FirstLetterOfMethodName 
                		else
                		@errrList = @FirstLetterOfMethodName
                		end
                		logErrorToDB(project_id,@file_destination ,"Controller",@file_destination,@NumberofLines,@FirstLetterOfMethodName)
                	end
                when "CheckUndefinedMethods"
                	if !@methodNotDefined.empty? and r_data.ReviewValue 
                		if @errrList != nil
                		@errrList = @errrList + @methodNotDefined
                		else
                		@errrList = @methodNotDefined
                		end
                		logErrorToDB(project_id,@file_destination ,"Controller",@file_destination,@NumberofLines,@FirstLetterOfMethodName)
                	end 
                when "NumberInMethod"
                	if !@NumberInMethod.empty? and r_data.ReviewValue 
                		if @errrList != nil
                		@errrList = @errrList + @NumberInMethod
                		else
                		@errrList = @NumberInMethod
                		end
                		logErrorToDB(project_id,@file_destination,"Controller",@file_destination,@NumberofLines,@NumberInMethod)
                	end
                when "CheckFileEncodeStatus"
                	if r_data.ReviewValue and !@CheckEncodingStatus.empty?
                		if @errrList != nil
                		@errrList = @errrList + @file_destination +  @CheckEncodingStatus
                		else
                		@errrList = @file_destination +  @CheckEncodingStatus
                		end
                		logErrorToDB(project_id,@file_destination,"Controller",@file_destination,@NumberofLines,@CheckEncodingStatus)
                	end
                when "QueriesPresentInFile"
                    if !@resChkQueriesInFile.empty? and r_data.ReviewValue
                        if @errrList != nil
                        @errrList = @errrList + @resChkQueriesInFile
                        else
                        @errrList = @errrList + @resChkQueriesInFile
                        end
                        logErrorToDB(project_id,@file_destination,"Controller", @file_destination,@NumberofLines,@resChkQueriesInFile)
                    end
                when "SetCharCountPerLine"
                	if @ChkCharCountPerLine > r_data.ReviewValue.to_i
            			if @errrList != nil
            			@errrList = @errrList + @resCharPerLine
            			else
            			@errrList = @resCharPerLine
            			end
            			logErrorToDB(project_id,@file_destination,"Controller", @file_destination,@NumberofLines,@resCharPerLine)
                	end
            	when "CheckSpaceAfterLineEnd"
            		if @spaceAfterLineEnd > 0 and r_data.ReviewValue
            			if @errrList != nil
            			@errrList = @errrList + @resSpaceAfterLineEnd
            			else
        				@errrList =  @resSpaceAfterLineEnd
            			end
            			logErrorToDB(project_id,@file_destination,"Controller", @file_destination,@NumberofLines,@resSpaceAfterLineEnd)
            		end
                when "ParameterCountInMethod"
                    if @ParamCountInMethod > r_data.ReviewValue.to_i
                        @NOPC_Error = @file_destination + " - Line number - " + @NumberofLines.to_s + " Number of parameters in methods of controller are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList +  @NOPC_Error 
                        else
                        @errrList = @NOPC_Error   
                        end
                        logErrorToDB(project_id, @file_destination ,"Controller",@file_destination,@NumberofLines,@NOPC_Error)
                    end
                when "NumberofComments"
                    if @NumberofComments > r_data.ReviewValue.to_i
                        @NOCM_Error = @file_destination + " - Line number - " + @NumberofLines.to_s + " Number of comments in controller are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList +  @NOCM_Error 
                        else
                        @errrList =  @NOCM_Error  
                        end
                        logErrorToDB(project_id, @file_destination ,"Controller",@file_destination,@NumberofLines,@NOCM_Error)
                    end
            	when "CheckDoubleQuotes"
            		if !@resCheckDoubleQuotes.empty? and r_data.ReviewValue
            			if @errrList != nil
            			@errrList = @errrList + @resCheckDoubleQuotes
            			else
            			@errrList = @resCheckDoubleQuotes
            			end
            			logErrorToDB(project_id,@file_destination,"Controller", @file_destination,@NumberofLines,@resCheckDoubleQuotes)
            		end
            	end
         	   end              
            end        
             @errrList
            rescue Exception => e
        	puts ("Found Error : "+e.to_s)
       
        end 
            end
		end
	end

	class ErrorFromModel < CodeReviewBase
        def self.getError(project_id,file_content,errrList,file_destination)
        if file_destination.split('/')[1].downcase == "models" 
        @errrList=errrList.to_s
        @NumberofLines = 0
        @NoOfClass = 0
        @FirstLetterOfClassName = ""
        @MultipleClass =""
        @NumberInClass =""
        @CheckEncodingStatus = ""
        @file_destination=file_destination
        @NumberofComments = 0
         begin

        @CheckEncodingStatus = @CheckEncodingStatus + " " + @file_destination + " - " + (CRA_logic_shraddha::CheckEncoding).getData(file_content,nil)  + "; "
        @ChkCharCountPerLine = ""
        @resCheckDoubleQuotes =""
        @resSpaceAfterLineEnd =""
        @resChkQueriesInFile = ""
            file_content.each_line do |line| 
                 @NumberofLines =  (CRA_logic_deep::NoOfLines).getData(@NumberofLines,nil)
                 @resCharPerLine =""    
                 @ChkCharCountPerLine = (CRA_logic_shraddha::CharCountPerLine).getData(line,nil)                 
                 @spaceAfterLineEnd = (CRA_logic_shraddha::SpaceAfterLineEnd).getData(line,nil) 
                 @ChkQueriesInFile = (CRA_logic_shraddha::QueriesInFile).getData(line,nil) 

                 if @ChkQueriesInFile != ""
                    @resChkQueriesInFile = @resChkQueriesInFile +  "\n Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - sql query words detect presence of sql queries in a file; \n"
                 end

                 if !(((CRA_logic_deep::CountWord).getData(line,"\"")).to_i.even? )
                    @resCheckDoubleQuotes = @resCheckDoubleQuotes + "Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - has uneven double quotes"
                 end
                 if @spaceAfterLineEnd > 0
                    @resSpaceAfterLineEnd = @resSpaceAfterLineEnd + "Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - contains trailing spaces after line end"
                 end
                 if @ChkCharCountPerLine > 0
                    @resCharPerLine = @resCharPerLine + "Line number - " + @NumberofLines.to_s + " " +@file_destination+ " - " + line + " - contains more number of character than expected in a line"
                 end
                if line.include? "#"
                    @NumberofComments = @NumberofComments + (CRA_logic_deep::NumberofComments).getData(@NumberofComments,nil).to_i
                 end
                if line.include? "class"
                    @NoOfClass =  (CRA_logic_deep::NoOfClass).getData(@NoOfClass,nil)

                    @indexof_class = line.index("class") - 4
                    if((CRA_logic_deep::IsUpper).getData(line[@indexof_class],nil) != "") 
                        @FirstLetterOfClassName = @FirstLetterOfClassName + "Line number - " + @NumberofLines.to_s + " " + @file_destination + " - " + line + " - contains invalid class name as first letter is capital" + "; " 
                    end
                    if(((CRA_logic_deep::CountWord).getData(line,"class")).to_i > 1)
                        @MultipleClass = @MultipleClass + "Line number - " + @NumberofLines.to_s + " " +   @file_destination  + " - " + line + " - contains class keyword multiple times" + "; "  
                    end  
                    if (CRA_logic_shraddha::CheckNumPresent).getData(line,nil) 
                        @NumberInClass = @NumberInClass + "Line number - " + @NumberofLines.to_s + " " + @file_destination  + " - " + line + " - contains number in class name" + "; "  
                    end                   
                end 
             end 

       #Check user specific rules
        @prjReviewArray = []
        @prjReviewArray = PrjReview.select { |prjreview| prjreview.project_id == project_id}
        @prjReviewArray.each do |r_data|

             if Review.find(r_data.review_id).FileType == "Model" 
                 case Review.find(r_data.review_id).ReviewName
                 when "Number of lines"
                    if @NumberofLines > r_data.ReviewValue.to_i
                        @NOL_Error = @file_destination  + " - " + " Number of lines in model are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList.to_s + @NOL_Error
                        else
                        @errrList = @NOL_Error
                        end
                        logErrorToDB(project_id,@file_destination ,"Model",@file_destination,@NumberofLines,@NOL_Error)
                    end

                when "Number of class"
                    if @NoOfClass > r_data.ReviewValue.to_i
                        @NOM_Error = @file_destination + " - " + " Number of class in model are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList +  @NOM_Error 
                        else
                        @errrList = @NOM_Error
                        end
                        logErrorToDB(project_id, @file_destination ,"Model",@file_destination,@NoOfClass,@NOM_Error)
                    end

                 when "Multiple_class_word"               
                     if !@MultipleClass.empty? and r_data.ReviewValue 
                        if @errrList != nil
                        @errrList = @errrList +   @MultipleClass
                        else
                        @errrList = @MultipleClass
                        end
                        logErrorToDB(project_id,@file_destination ,"Model",@file_destination,@NumberofLines,@MultipleClass)
                     end
                 
                when "CapitalizeFirstLetterOfClass" 
                    if !@FirstLetterOfClassName.empty? and r_data.ReviewValue 
                        if @errrList != nil
                        @errrList = @errrList + @FirstLetterOfClassName 
                        else
                        @errrList = @FirstLetterOfClassName
                        end
                        logErrorToDB(project_id,@file_destination ,"Model",@file_destination,@NumberofLines,@FirstLetterOfClassName)
                    end
                when "NumberInClass"
                    if !@NumberInClass.empty? and r_data.ReviewValue 
                        if @errrList != nil
                        @errrList = @errrList + @NumberInClass
                        else
                        @errrList = @NumberInClass
                        end
                        logErrorToDB(project_id,@file_destination,"Model",@file_destination,@NumberofLines,@NumberInClass)
                    end
                when "CheckFileEncodeStatus"
                    if r_data.ReviewValue and !@CheckEncodingStatus.empty?
                        if @errrList != nil
                        @errrList = @errrList + @file_destination +  @CheckEncodingStatus
                        else
                        @errrList = @file_destination +  @CheckEncodingStatus
                        end
                        logErrorToDB(project_id,@file_destination,"Model",@file_destination,@NumberofLines,@CheckEncodingStatus)
                    end
                when "QueriesPresentInFile"
                    if !@resChkQueriesInFile.empty? and r_data.ReviewValue
                        if @errrList != nil
                        @errrList = @errrList + @resChkQueriesInFile
                        else
                        @errrList = @errrList + @resChkQueriesInFile
                        end
                        logErrorToDB(project_id,@file_destination,"Model", @file_destination,@NumberofLines,@resChkQueriesInFile)
                    end
                when "SetCharCountPerLine"
                    if @ChkCharCountPerLine > r_data.ReviewValue.to_i
                        if @errrList != nil
                        @errrList = @errrList + @resCharPerLine
                        else
                        @errrList = @resCharPerLine
                        end
                        logErrorToDB(project_id,@file_destination,"Model", @file_destination,@NumberofLines,@resCharPerLine)
                    end
                when "CheckSpaceAfterLineEnd"
                    if @spaceAfterLineEnd > 0 and r_data.ReviewValue
                        if @errrList != nil
                        @errrList = @errrList + @resSpaceAfterLineEnd
                        else
                        @errrList =  @resSpaceAfterLineEnd
                        end
                        logErrorToDB(project_id,@file_destination,"Model", @file_destination,@NumberofLines,@resSpaceAfterLineEnd)
                    end
                when "NumberofComments"
                    if @NumberofComments > r_data.ReviewValue.to_i
                        @NOCM_Error = @file_destination + " - Line number - " + @NumberofLines.to_s + " Number of comments in model are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList +  @NOCM_Error 
                        else
                        @errrList =  @NOCM_Error  
                        end
                        logErrorToDB(project_id, @file_destination ,"Model",@file_destination,@NumberofLines,@NOCM_Error)
                    end
                when "CheckDoubleQuotes"
                    if !@resCheckDoubleQuotes.empty? and r_data.ReviewValue
                        if @errrList != nil
                        @errrList = @errrList + @resCheckDoubleQuotes
                        else
                        @errrList = @resCheckDoubleQuotes
                        end
                        logErrorToDB(project_id,@file_destination,"Model", @file_destination,@NumberofLines,@resCheckDoubleQuotes)
                    end
                end
               end              
            end        
             @errrList
            rescue Exception => e
            puts ("Found Error : "+e.to_s)
       
        end 
            end
        end
	end

	class ErrorFromView < CodeReviewBase

        def self.getError(project_id,file_content,errrList,file_destination)
        if file_destination.split('/')[1].downcase == "views" 
            @errrList=errrList.to_s
            @NumberofLines = 0
        @FirstLetterOfMethodName = ""
        @MultipleDef =""
        @NumberInMethod =""
        @CheckEncodingStatus = ""
        @file_destination=file_destination
        @NumberofComments = 0
        @resChkQueriesInFile = ""
         begin
        @CheckEncodingStatus = @CheckEncodingStatus + " " + @file_destination + " - " + (CRA_logic_shraddha::CheckEncoding).getData(file_content,nil)  + "; "
         @ChkCharCountPerLine = ""
        @resCheckDoubleQuotes =""
        @resSpaceAfterLineEnd =""
            file_content.each_line do |line|
                 @NumberofLines =  (CRA_logic_deep::NoOfLines).getData(@NumberofLines,nil)
                 @resCharPerLine =""                    
                  
                 @ChkCharCountPerLine = (CRA_logic_shraddha::CharCountPerLine).getData(line,nil)                 
                 @spaceAfterLineEnd = (CRA_logic_shraddha::SpaceAfterLineEnd).getData(line,nil) 
                 @ChkQueriesInFile = (CRA_logic_shraddha::QueriesInFile).getData(line,nil) 

                 if @ChkQueriesInFile != ""
                    @resChkQueriesInFile = @resChkQueriesInFile +  "\n Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - sql query words detect presence of sql queries in a file; \n"
                 end                 
                 if !(((CRA_logic_deep::CountWord).getData(line,"\"")).to_i.even? )
                    @resCheckDoubleQuotes = @resCheckDoubleQuotes + "Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - has uneven double quotes"
                 end
                 if @spaceAfterLineEnd > 0
                    @resSpaceAfterLineEnd = @resSpaceAfterLineEnd + "Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - contains trailing spaces after line end"
                 end
                 if @ChkCharCountPerLine > 0
                    @resCharPerLine = @resCharPerLine + "Line number - " + @NumberofLines.to_s + " " +@file_destination+ " - " + line + " - contains more number of character than expected in a line"
                 end
                if line.include? "<!--"
                    @NumberofComments = @NumberofComments + (CRA_logic_deep::NumberofComments).getData(@NumberofComments,nil).to_i
                 end
             end 

       #Check user specific rules
        @prjReviewArray = []
        @prjReviewArray = PrjReview.select { |prjreview| prjreview.project_id == project_id}
        @prjReviewArray.each do |r_data|

             if Review.find(r_data.review_id).FileType == "View" 
                 case Review.find(r_data.review_id).ReviewName
                    #puts Review.find(r_data.review_id).ReviewName
                 when "Number of lines"
                    if @NumberofLines > r_data.ReviewValue.to_i
                        @NOL_Error = @file_destination  + " - " + " Number of lines in view are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList + @NOL_Error
                        else
                        @errrList = @NOL_Error
                        end
                        logErrorToDB(project_id,@file_destination ,"View",@file_destination,@NumberofLines,@NOL_Error)
                    end
                when "CheckFileEncodeStatus"
                    if r_data.ReviewValue and !@CheckEncodingStatus.empty?
                        if @errrList != nil
                        @errrList = @errrList + @file_destination +  @CheckEncodingStatus
                        else
                        @errrList = @file_destination +  @CheckEncodingStatus
                        end
                        logErrorToDB(project_id,@file_destination,"View",@file_destination,@NumberofLines,@CheckEncodingStatus)
                    end
                when "QueriesPresentInFile"
                    if !@resChkQueriesInFile.empty? and r_data.ReviewValue
                        if @errrList != nil
                        @errrList = @errrList + @resChkQueriesInFile
                        else
                        @errrList = @errrList + @resChkQueriesInFile
                        end
                        logErrorToDB(project_id,@file_destination,"View", @file_destination,@NumberofLines,@resChkQueriesInFile)
                    end
                when "SetCharCountPerLine"
                    if @ChkCharCountPerLine > r_data.ReviewValue.to_i
                        if @errrList != nil
                        @errrList = @errrList + @resCharPerLine
                        else
                        @errrList = @resCharPerLine
                        end
                        logErrorToDB(project_id,@file_destination,"View", @file_destination,@NumberofLines,@resCharPerLine)
                    end
                when "CheckSpaceAfterLineEnd"
                    if @spaceAfterLineEnd > 0 and r_data.ReviewValue
                        if @errrList != nil
                        @errrList = @errrList + @resSpaceAfterLineEnd
                        else
                        @errrList =  @resSpaceAfterLineEnd
                        end
                        logErrorToDB(project_id,@file_destination,"View", @file_destination,@NumberofLines,@resSpaceAfterLineEnd)
                    end
                when "ParameterCountInMethod"
                    if @ParamCountInMethod > r_data.ReviewValue.to_i
                        @NOPC_Error = @file_destination + " - Line number - " + @NumberofLines.to_s + " Number of parameters in methods of view are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList +  @NOPC_Error 
                        else
                        @errrList = @NOPC_Error   
                        end
                        logErrorToDB(project_id, @file_destination ,"View",@file_destination,@NumberofLines,@NOPC_Error)
                    end
                when "NumberofComments"
                    if @NumberofComments > r_data.ReviewValue.to_i
                        @NOCM_Error = @file_destination + " - Line number - " + @NumberofLines.to_s + " Number of comments in view are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList +  @NOCM_Error 
                        else
                        @errrList =  @NOCM_Error  
                        end
                        logErrorToDB(project_id, @file_destination ,"View",@file_destination,@NumberofLines,@NOCM_Error)
                    end
                when "CheckDoubleQuotes"
                    if !@resCheckDoubleQuotes.empty? and r_data.ReviewValue
                        if @errrList != nil
                        @errrList = @errrList + @resCheckDoubleQuotes
                        else
                        @errrList = @resCheckDoubleQuotes
                        end
                        logErrorToDB(project_id,@file_destination,"View", @file_destination,@NumberofLines,@resCheckDoubleQuotes)
                    end
                end
               end              
            end        
             @errrList
            rescue Exception => e
            puts ("Found Error : "+e.to_s)
       
        end 
            end
        end
    end

class ErrorFromHelper < CodeReviewBase
        def self.getError(project_id,file_content,errrList,file_destination)
        if file_destination.split('/')[1].downcase == "helpers" 
            @errrList=errrList.to_s
            @NumberofLines = 0
        @NumberofMethods = 0
        @FirstLetterOfMethodName = ""
        @MultipleDef =""
        @chkMethodCall =""
        @methodNotDefined = ""
        @NumberInMethod =""
        @CheckEncodingStatus = ""
        @file_destination=file_destination
        @NumberofComments = 0
        @ParamCountInMethod = 0
         begin
        @CheckEncodingStatus = @CheckEncodingStatus + " " + @file_destination + " - " + (CRA_logic_shraddha::CheckEncoding).getData(file_content,nil)  + "; "
         @ChkCharCountPerLine = ""
        @resCheckDoubleQuotes =""
        @resSpaceAfterLineEnd =""
            file_content.each_line do |line|
                 @NumberofLines =  (CRA_logic_deep::NoOfLines).getData(@NumberofLines,nil)
                 @resCharPerLine =""                    

                 @chkMethodCall =  line.match(/\..*\(/) #get method called in one line
                 @ChkCharCountPerLine = (CRA_logic_shraddha::CharCountPerLine).getData(line,nil)                 
                 @spaceAfterLineEnd = (CRA_logic_shraddha::SpaceAfterLineEnd).getData(line,nil) 
                
                 if !(((CRA_logic_deep::CountWord).getData(line,"\"")).to_i.even? )
                    @resCheckDoubleQuotes = @resCheckDoubleQuotes + "Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - has uneven double quotes"
                 end
                 if @spaceAfterLineEnd > 0
                    @resSpaceAfterLineEnd = @resSpaceAfterLineEnd + "Line number - " + @NumberofLines.to_s  + " " +@file_destination+ " - " + line + " - contains trailing spaces after line end"
                 end
                 if @ChkCharCountPerLine > 0
                    @resCharPerLine = @resCharPerLine + "Line number - " + @NumberofLines.to_s + " " +@file_destination+ " - " + line + " - contains more number of character than expected in a line"
                 end
                if line.include? "#"
                    @NumberofComments = @NumberofComments + (CRA_logic_deep::NumberofComments).getData(@NumberofComments,nil).to_i
                 end
                if line.include? "def"
                    @ParamCountInMethod = (CRA_logic_shraddha::ParamCntInMethod).getData(@ParamCntInMethod,nil)
                    @NumberofMethods =  (CRA_logic_deep::NoOfMethods).getData(@NumberofMethods,nil)
                    @indexof_met = line.index("def")    + 4 
                    if((CRA_logic_deep::IsUpper).getData(line[@indexof_met],nil) != "") 
                        @FirstLetterOfMethodName = @FirstLetterOfMethodName + "Line number - " + @NumberofLines.to_s + " " + @file_destination + " - " + line + " - contains invalid method name as first letter is capital" + "; " 
                    end
                    if(((CRA_logic_deep::CountWord).getData(line,"def")).to_i > 1)
                        @MultipleDef = @MultipleDef + "Line number - " + @NumberofLines.to_s + " " +   @file_destination  + " - " + line + " - contains def keyword multiple times" + "; "  
                    end  
                    if (CRA_logic_shraddha::CheckNumPresent).getData(line,nil) 
                        @NumberInMethod = @NumberInMethod + "Line number - " + @NumberofLines.to_s + " " + @file_destination  + " - " + line + " - contains number in method name" + "; "  
                    end                   
                end 
                if @chkMethodCall.to_s != ""
                    @chkMethodCall = (CRA_logic_deep::MethodCallCount).getData(@chkMethodCall,nil) 
                    @chkFormat = defined? @chkMethodCall
                    if @chkFormat == nil
                        @methodNotDefined = @methodNotDefined + "Line number - " + @NumberofLines.to_s + " " +  @file_destination  + " - " + line + "Call to undefined method"
                    end
                end
             end 

       #Check user specific rules
        @prjReviewArray = []
        @prjReviewArray = PrjReview.select { |prjreview| prjreview.project_id == project_id}
        @prjReviewArray.each do |r_data|

             if Review.find(r_data.review_id).FileType == "Helper" 
                 case Review.find(r_data.review_id).ReviewName
                    #puts Review.find(r_data.review_id).ReviewName
                 when "Number of lines"
                    if @NumberofLines > r_data.ReviewValue.to_i
                        @NOL_Error = @file_destination  + " - " + " Number of lines in helper are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList + @NOL_Error
                        else
                        @errrList = @NOL_Error
                        end
                        logErrorToDB(project_id,@file_destination ,"Helper",@file_destination,@NumberofLines,@NOL_Error)
                    end

                when "Number of methods"
                    if @NumberofMethods > r_data.ReviewValue.to_i
                        @NOM_Error = @file_destination + " - " + " Number of methods in helper are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList +  @NOM_Error 
                        else
                        @errrList = @NOM_Error
                        end
                        logErrorToDB(project_id, @file_destination ,"Helper",@file_destination,@NumberofMethods,@NOM_Error)
                    end

                 when "Multiple_def_word"               
                     if !@MultipleDef.empty? and r_data.ReviewValue 
                        if @errrList != nil
                        @errrList = @errrList +   @MultipleDef
                        else
                        @errrList = @MultipleDef
                        end
                        logErrorToDB(project_id,@file_destination ,"Helper",@file_destination,@NumberofLines,@MultipleDef)
                     end
                 
                when "CapitalizeFirstLetterOfMethod" 
                    if !@FirstLetterOfMethodName.empty? and r_data.ReviewValue 
                        if @errrList != nil
                        @errrList = @errrList + @FirstLetterOfMethodName 
                        else
                        @errrList = @FirstLetterOfMethodName
                        end
                        logErrorToDB(project_id,@file_destination ,"Helper",@file_destination,@NumberofLines,@FirstLetterOfMethodName)
                    end
                when "CheckUndefinedMethods"
                    if !@methodNotDefined.empty? and r_data.ReviewValue 
                        if @errrList != nil
                        @errrList = @errrList + @methodNotDefined
                        else
                        @errrList = @methodNotDefined
                        end
                        logErrorToDB(project_id,@file_destination ,"Helper",@file_destination,@NumberofLines,@FirstLetterOfMethodName)
                    end 
                when "NumberInMethod"
                    if !@NumberInMethod.empty? and r_data.ReviewValue 
                        if @errrList != nil
                        @errrList = @errrList + @NumberInMethod
                        else
                        @errrList = @NumberInMethod
                        end
                        logErrorToDB(project_id,@file_destination,"Helper",@file_destination,@NumberofLines,@NumberInMethod)
                    end
                when "CheckFileEncodeStatus"
                    if r_data.ReviewValue and !@CheckEncodingStatus.empty?
                        if @errrList != nil
                        @errrList = @errrList + @file_destination +  @CheckEncodingStatus
                        else
                        @errrList = @file_destination +  @CheckEncodingStatus
                        end
                        logErrorToDB(project_id,@file_destination,"Helper",@file_destination,@NumberofLines,@CheckEncodingStatus)
                    end
                when "SetCharCountPerLine"
                    if @ChkCharCountPerLine > r_data.ReviewValue.to_i
                        if @errrList != nil
                        @errrList = @errrList + @resCharPerLine
                        else
                        @errrList = @resCharPerLine
                        end
                        logErrorToDB(project_id,@file_destination,"Helper", @file_destination,@NumberofLines,@resCharPerLine)
                    end
                when "CheckSpaceAfterLineEnd"
                    if @spaceAfterLineEnd > 0 and r_data.ReviewValue
                        if @errrList != nil
                        @errrList = @errrList + @resSpaceAfterLineEnd
                        else
                        @errrList =  @resSpaceAfterLineEnd
                        end
                        logErrorToDB(project_id,@file_destination,"Helper", @file_destination,@NumberofLines,@resSpaceAfterLineEnd)
                    end
                when "ParameterCountInMethod"
                    if @ParamCountInMethod > r_data.ReviewValue.to_i
                        @NOPC_Error = @file_destination + " - Line number - " + @NumberofLines.to_s + " Number of parameters in methods of helper are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList +  @NOPC_Error 
                        else
                        @errrList = @NOPC_Error   
                        end
                        logErrorToDB(project_id, @file_destination ,"Helper",@file_destination,@NumberofLines,@NOPC_Error)
                    end
                when "NumberofComments"
                    if @NumberofComments > r_data.ReviewValue.to_i
                        @NOCM_Error = @file_destination + " - Line number - " + @NumberofLines.to_s + " Number of comments in helper are greater than predefined criteria; "
                        if @errrList != nil
                        @errrList = @errrList +  @NOCM_Error 
                        else
                        @errrList =  @NOCM_Error  
                        end
                        logErrorToDB(project_id, @file_destination ,"Helper",@file_destination,@NumberofLines,@NOCM_Error)
                    end
                when "CheckDoubleQuotes"
                    if !@resCheckDoubleQuotes.empty? and r_data.ReviewValue
                        if @errrList != nil
                        @errrList = @errrList + @resCheckDoubleQuotes
                        else
                        @errrList = @resCheckDoubleQuotes
                        end
                        logErrorToDB(project_id,@file_destination,"Helper", @file_destination,@NumberofLines,@resCheckDoubleQuotes)
                    end
                end
            end              
               end    
             @errrList
            rescue Exception => e
            puts ("Found Error : "+e.to_s)
       
        end 
        
       end 
    end
end
end