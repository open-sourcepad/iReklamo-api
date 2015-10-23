if @complaint.present?

  json.success "true"
  json.partial! "api/complaints/complaint", complaint: @complaint

  json.comments do
    @complaint.comments do |comment|
      json.id comment.id
      json.title comment.title
      json.description comment.description
    end
  end

  json.likes @complaint.likes.count

else

  json.success "false"
  json.message "Error on getting complaint"

end
