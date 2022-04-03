require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:user) { create(:user) }
  let(:office) { create(:office, created_by: user) }

  before { sign_in user }

  describe '#dashboard' do
    context 'with existing office' do
      it 'renders dashboard view' do
        create(:member, office: office, user: user)

        get :dashboard

        expect(response).to redirect_to [:new, office, :data_model]
      end
    end

    context 'with existing office and data model' do
      it 'renders dashboard view' do
        create(:member, office: office, user: user)
        data_model = create(:data_model, office: office)

        get :dashboard

        expect(response).to redirect_to [office, data_model, :instances]
      end
    end

    context 'with no offices' do
      it 'renders dashboard view' do
        get :dashboard

        expect(response).to render_template(:dashboard)
      end
    end
  end
end
