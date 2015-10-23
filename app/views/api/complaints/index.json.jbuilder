json.success "true"

if params[:latitude] && params[:longitude]
  json.message "Complaints within 20 miles radius from this point [#{params[:latitude]},#{params[:longitude]}]"
else
  json.message "All Complaints"
end

json.complaints @complaints, partial: 'api/complaints/complaint', as: :complaint
