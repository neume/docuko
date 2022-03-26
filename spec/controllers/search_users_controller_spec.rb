require 'rails_helper'

RSpec.describe SearchUsersController, type: :controller do
  let(:user) { create(:user) }
  let(:office) { create(:office, created_by: user) }

  before do
    sign_in user
    allow(controller).to receive(:current_office).and_return(office)
  end

  describe '#index' do
    render_views

    let(:available_user) { create(:user, email: 'juan@test') }

    before do
      available_user
      create(:user, email: 'pedro@test')

      # already a member
      create(:user, with_office: office, email: 'juanito@local')

      get :index, params: slug(search: 'juan'), format: :json
    end

    it 'returns filtered users' do
      json = JSON.parse(response.body)

      expect(json).to eq([{ 'email' => 'juan@test', 'id' => available_user.id }])
    end
  end
end
