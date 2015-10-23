require 'rails_helper'

RSpec.describe Api::LikesController do
  describe 'POST create' do
    context 'happy path' do
      it 'creates a like linked to the complaint/user/commenter' do
        user = create(:user)
        complaint = create(:complaint, user: user)

        post :create, user_id: user.id, complaint_id: complaint.id

        expect(complaint.likes.length).to eq 1
        expect(user.likes.length).to eq 1
      end
    end
  end
end
