json.extract! prj_review, :id, :project_id, :review_id, :ReviewType, :ReviewValue, :created_at, :updated_at
json.url prj_review_url(prj_review, format: :json)
