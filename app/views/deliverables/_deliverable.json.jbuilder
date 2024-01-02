json.extract! deliverable, :id, :name, :deadline, :project_id, :created_at, :updated_at
json.url deliverable_url(deliverable, format: :json)
