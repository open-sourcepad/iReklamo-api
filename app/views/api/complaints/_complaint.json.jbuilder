json.complaint do
  json.extract! complaint, *%i(
    id
    title
    description
    latitude
    longitude
    category
  )
  json.image_url complaint.image.url

  json.comments do
    complaint.comments do |comment|
      json.id comment.id
      json.title comment.title
      json.description comment.description
    end
  end

  json.likes complaint.likes.count
end
