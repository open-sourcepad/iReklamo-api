require 'rails_helper'

RSpec.describe Api::LikesController do
  describe 'POST create' do
    context 'logged in' do
      before(:each) do
        allow(controller).to receive(:authenticate_token_from_user!).and_return true
      end

      context 'happy path' do
        it 'creates a like linked to the complaint/user/commenter' do
          user = create(:user)
          complaint = create(:complaint, user: user)

          post :create, user_id: user.id, complaint_id: complaint.id

          expect(complaint.likes.length).to eq 1
          expect(user.likes.length).to eq 1
        end
      end

      context 'can\'t like twice' do
        it 'is not fetch' do
          user = create(:user)
          complaint = create(:complaint, user: user)
          Like.create(complaint_id: complaint.id, user_id: user.id)

          post :create, user_id: user.id, complaint_id: complaint.id

          expect(complaint.likes.length).to eq 1
          expect(response.status).to eq 422
        end
      end
    end
  end
end
