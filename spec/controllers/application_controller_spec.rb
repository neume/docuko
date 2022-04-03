require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) do
    user = create(:user)
    office = create(:office, slug: 'test')
    create(:member, office: office, user: user, member_role: :regular)
    user
  end

  controller(described_class) do
    before_action :authorize_admin!

    def index; end
  end

  describe 'test' do
    it 'redirects regular users' do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
      get :index, params: { office_slug: 'test' }
      # sign_in user
      expect(response).to redirect_to(root_path)
    end
  end
end
