json.extract! page_master, :id, :pagename, :pagelink, :created_at, :updated_at
json.url page_master_url(page_master, format: :json)
