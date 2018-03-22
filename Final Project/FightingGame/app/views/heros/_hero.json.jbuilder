json.extract! hero, :id, :name, :atk, :hp, :def, :speed, :type, :user_id, :created_at, :updated_at
json.url hero_url(hero, format: :json)
