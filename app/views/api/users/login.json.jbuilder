if @success

  json.success "true"
  json.partial! "api/users/user", user: @user

else

  json.false "false"
  json.message "Invalid Email / Password"

end
