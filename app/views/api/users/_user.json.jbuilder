json.user do
  json.extract! user, *%i(
    id
    email_address
    name
    access_token
  )
end
