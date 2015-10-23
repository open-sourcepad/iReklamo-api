if @user.errors.empty?

  json.success "true"
  json.user do
    json.extract! @user, *%i(
      id
      email_address
      name
      access_token
    )

  end

else

  json.success "false"
  json.message "#{@user.errors.full_messages.join('. ')}"

end
