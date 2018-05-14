# use json object and specify what attributes to show
json.articles_count @articles.size
json.articles(@articles, :title, :slug, :body, :created_at, :updated_at,
    :tag_list, :description, :author,
    :favorited, :favorites_count)

# here's the longer version
# json.articles do |article|
#   json.(article, :title, :slug, :body, :created_at, :updated_at,
#     :description, :favorited, :favorites_count)
# end