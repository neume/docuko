require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:user) { create(:user) }
  let(:office) { create(:office, created_by: user) }

  describe '#dashboard' do
    it 'renders dashboard view' do
      office

      get :dashboard

      expect(response).to render_template(:dashboard)
    end
  end
end
