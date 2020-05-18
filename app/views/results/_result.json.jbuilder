json.extract! result, :id, :Project_id, :Folder_Name, :Type_Of_File, :FileName, :Error_Line_Number, :Error_Description, :created_at, :updated_at
json.url result_url(result, format: :json)
