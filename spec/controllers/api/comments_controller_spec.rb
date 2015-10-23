require 'rails_helper'

RSpec.describe Api::CommentsController do
  describe 'POST create' do
    context 'happy path' do
      it 'creates a comment linked to the complaint/user/commenter' do
        user = create(:user)
        complaint = create(:complaint, user: user)

        post :create, user_id: user.id, complaint_id: complaint, comment: {
          title: Faker::App.name,
          description: Faker::Lorem.paragraph
        }

        expect(complaint.comments.length).to eq 1
        expect(user.comments.length).to eq 1
      end
    end
  end
end
