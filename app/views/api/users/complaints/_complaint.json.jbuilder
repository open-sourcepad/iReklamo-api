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
end
