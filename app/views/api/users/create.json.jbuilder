if @user.errors.empty?

  json.success "true"
  json.message "User Created"
  json.partial! "api/users/user", user: @user

else

  json.success "false"
  json.message "#{@user.errors.full_messages.join('. ')}"

end
