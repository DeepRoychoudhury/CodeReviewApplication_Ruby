require 'CRA_Base'
require 'aws-sdk-rails'
require 'aws-sdk-s3'  # v2: require 'aws-sdk'
require 'json'
require 'finddotindirectoryname'
require_relative '../../lib/uploadLibrary/lib/zip'
class ProjectsController < ApplicationController
def index
      @user=User.find(current_user.id)
      @projects = @user.projects
end

def show
  @file_url =""
  @project = Project.find(params[:id])
   s = Aws::S3::Resource.new(
     access_key_id:  Figaro.env.AWS_ACCESS_KEY_ID,
     secret_access_key: Figaro.env.AWS_SECRET_ACCESS_KEY,
     session_token: Figaro.env.aws_session_token,
     region: 'us-east-1'
     )
  folder_name = (@project.id.to_i).to_s 
  file_name = (@project.ProjectName).to_s + ".zip"
  obj = s.bucket(Figaro.env.S3_BUCKET_NAME).object("#{folder_name}/#{file_name}")
  # obj.get(response_target: '\tmp')
  if Project.count == 1
    @file_url = "https://"+Figaro.env.S3_BUCKET_NAME+".s3.amazonaws.com/1/" + @project.ProjectName.to_s + ".zip"
  else
  @file_url = "https://"+Figaro.env.S3_BUCKET_NAME+".s3.amazonaws.com/" + @project.id.to_s + "/" + @project.ProjectName.to_s + ".zip"
  end 
  data = open(@file_url) 
  send_data data.read, filename: file_name, type: "application/zip", disposition: 'inline', stream: 'true', buffer_size: '4096' 

end

def new
  @user = User.find(params[:user_id])
  @project = @user.projects.build

end

def create
  begin
  count = 0
  @user = User.find(params[:user_id])
   s = Aws::S3::Resource.new(
     access_key_id:  Figaro.env.AWS_ACCESS_KEY_ID,
     secret_access_key: Figaro.env.AWS_SECRET_ACCESS_KEY,
     session_token: Figaro.env.aws_session_token,
     region: 'us-east-1'
     )
if !Project.exists?
  folder_name='1'
else
  folder_name = (Project.last.id.to_i + 1).to_s 
end
  file_name = (params[:project][:ProjectName]).to_s + ".zip"
  binding.pry
  obj = s.bucket(Figaro.env.S3_BUCKET_NAME).object("#{folder_name}/#{file_name}")
  obj.put(body: params[:project][:Path])

@actualProjId = 0
  
@review_master = Review.all.map { |r,s| [r.id,r.ReviewValue] }
  
  if Project.exists?(["\"ProjectName\" = ?", "#{(params[:project][:ProjectName]).to_s }"]) && count == 0
    count = count + 1

  sql = "select id from Projects where \"ProjectName\" = '#{(params[:project][:ProjectName]).to_s}' "

  @pid= ActiveRecord::Base.connection.execute(sql) 
  @actualProjId =  @pid[0].values[0].to_i
  PrjReview.select do |prjreview|
    prjreview.project_id == @actualProjId.to_i
    prjreview.destroy
  end
  @review_master.each do |r_data|
    inserts = []
    time = Time.now
    inserts.push "('D','#{r_data[1]}', #{@actualProjId.to_i}, #{r_data[0]}, '#{time}','#{time}')"
  sql = "INSERT INTO prj_reviews(\"ReviewType\",\"ReviewValue\",project_id,review_id,created_at,updated_at) VALUES #{inserts.join(", ")}"
        ActiveRecord::Base.connection.execute(sql) 
      end      
    end

  @project = @user.projects.build(params.require(:project).permit(:ProjectName,:Path,:Status))
  if @project.save
    @actualProjId = Project.last.id
       
      PrjReview.select do |prjreview|
        prjreview.project_id == @actualProjId.to_i
        prjreview.destroy
    end
      
    @review_master = Review.all.map { |r,s| [r.id,r.ReviewValue] }
    @last_project = Project.last
    @review_master.each do |r_data|
    
    # PrjReview.create(:review_id => r_data[0], :project_id => @last_project.id,:ReviewType => "D", :ReviewValue => r_data[1], :created_at => Date.today, :updated_at => Date.today )            
    inserts = []
    time = Time.now
     inserts.push "('D','#{r_data[1]}', #{@actualProjId}, #{r_data[0]}, '#{time}','#{time}')"
    @rvtype="ReviewType"
    @rvval ="ReviewValue"

    sql = "INSERT INTO prj_reviews(\"ReviewType\",\"ReviewValue\",project_id,review_id,created_at,updated_at) VALUES #{inserts.join(", ")}"
    ActiveRecord::Base.connection.execute(sql) 
  end      
end

Result.select do |result|
  result.project_id == @actualProjId.to_i
  result.destroy
end

Zip::File.open(params[:project][:Path]) do |zip_file|
  @myhtml = ""
  @errrList = ""
  zip_file.each do |entry|            
    if entry.file? 
      @file_content = entry.get_input_stream.read
      @file_destination = "/" + entry.name.split('/')[entry.name.split('/').count - 2]  + "/" + entry.name.split('/')[entry.name.split('/').count - 1] 
      if entry.name.split('/')[entry.name.split('/').count - 2].downcase == "controllers" 
      if @errrList != nil
         @errrList = @errrList + (CRA_base::ErrorFromController).finding_Errors(@actualProjId,@file_content,@errrList,@file_destination)
      else
          @errrList = (CRA_base::ErrorFromController).finding_Errors(@actualProjId,@file_content,@errrList,@file_destination)  
      end
      end
      if entry.name.split('/')[entry.name.split('/').count - 2].downcase == "models" 
      if @errrList != nil
      @errrList = @errrList + (CRA_base::ErrorFromModel).finding_Errors(@actualProjId,@file_content,@errrList,@file_destination)
      else
      @errrList = (CRA_base::ErrorFromModel).finding_Errors(@actualProjId,@file_content,@errrList,@file_destination)  
      end
      end
      if entry.name.split('/')[entry.name.split('/').count - 2].downcase == "views" 
        if @errrList != nil
          @errrList = @errrList + (CRA_base::ErrorFromView).finding_Errors(@actualProjId,@file_content,@errrList,@file_destination)
        else
          @errrList = (CRA_base::ErrorFromView).finding_Errors(@actualProjId,@file_content,@errrList,@file_destination)  
        end
      end
      if entry.name.split('/')[entry.name.split('/').count - 2].downcase == "helpers" 
        if @errrList != nil
          @errrList = @errrList + (CRA_base::ErrorFromHelper).finding_Errors(@actualProjId,@file_content,@errrList,@file_destination)
        else
          @errrList = (CRA_base::ErrorFromHelper).finding_Errors(@actualProjId,@file_content,@errrList,@file_destination)  
        end
      end
    end
    end

  Note.create(:project_id => @actualProjId,:notepad => "",:notify => 'N')
  redirect_to user_projects_path(@user,@project), notice: "Successfully uploaded." 
 end
rescue Exception => e
  puts ("Exception Found : "+e.to_s)
  if e.class.to_s=="Aws::S3::Errors::ExpiredToken"
    @error="Token has expired. Please contact your Admin for a valid Token to upload."
    redirect_to new_user_project_path(current_user.id), notice: @error
  end
end
end

def destroy
  begin
  @project = Project.find(params[:id])
  s = Aws::S3::Resource.new(
    access_key_id:  Figaro.env.AWS_ACCESS_KEY_ID,
    secret_access_key: Figaro.env.AWS_SECRET_ACCESS_KEY,
    session_token: Figaro.env.aws_session_token,
    region: 'us-east-1'
    )
  folder_name = (@project.id.to_i).to_s 
  file_name = (@project.ProjectName).to_s + ".zip"
  obj = s.bucket(Figaro.env.S3_BUCKET_NAME).object("#{folder_name}/#{file_name}")
  obj.delete
  # @project.destroy
  redirect_to user_projects_path(current_user.id), notice:  "Successfully deleted."
rescue Exception => e
  puts ("Found Exception : "+e.to_s)
  if e.class.to_s=="Aws::S3::Errors::ExpiredToken"
    @error="Token has expired. Please contact your Admin for a valid Token to delete."
  redirect_to user_projects_path(current_user.id), notice: @error
end
end
end

private
def project_params
  params.require(:project).permit(:name, :attachment,:Path)
end
end