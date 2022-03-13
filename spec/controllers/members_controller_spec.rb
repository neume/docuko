require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:user) { create(:user) }
  let(:office) { create(:office, created_by: user) }

  before do
    sign_in user
    allow(controller).to receive(:authorize_admin!).and_return(true)
    allow(controller).to receive(:current_office).and_return(office)
  end

  describe '#index' do
    before { get :index, params: slug }

    it { expect(response).to render_template(:index) }
  end

  describe '#new' do
    before { get :new, params: slug }

    it { expect(response).to render_template(:new) }
  end

  describe '#create' do
    let(:other_user) { create(:user) }
    let(:valid_params) do
      {
        member: {
          user_id: other_user.id,
          member_role: :admin
        }
      }
    end

    it 'adds new member' do
      post :create, params: slug(valid_params)
      expect(office.members.count).to eq(1) # the original user was not a member
    end
  end

  describe '#change_role' do
    before do
      patch :change_role, params: slug(id: member.id, member_role: 'regular'), xhr: true, format: :js
    end

    context 'with other members' do
      let(:member) { create(:member, office: office, member_role: 'admin') }

      it 'changes member role' do
        member.reload
        expect(member).to be_regular
        expect(response).to render_template(:change_role)
      end
    end

    context 'with own membership' do
      let(:member) { create(:member, office: office, member_role: 'admin', user: user) }

      it 'does not allow changing of membership' do
        member.reload
        expect(member).to be_admin
      end
    end
  end
end
