if @complaint.present?

  json.success "true"
  json.partial! "api/complaints/complaint", complaint: @complaint

else

  json.success "false"
  json.message "Error on getting complaint"

end
