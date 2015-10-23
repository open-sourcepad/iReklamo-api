require 'rails_helper'
require './db/seeds'

RSpec.describe SeedEverything  do
  describe 'go' do
    it 'Seeds' do
      SeedEverything.go

      expect(Complaint.all.length).to eq 9
    end
  end
end
