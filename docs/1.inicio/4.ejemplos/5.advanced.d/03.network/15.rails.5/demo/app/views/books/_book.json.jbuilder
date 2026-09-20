json.extract! book, :id, :name, :phone, :created_at, :updated_at
json.url book_url(book, format: :json)
