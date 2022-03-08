require 'rails_helper'

RSpec.describe TemplatesController, type: :routing do
  let(:base_params) do
    {
      controller: 'templates',
      office_slug: 'clinic'
    }
  end

  describe 'routing' do
    it 'routes to #new' do
      expect(get: "/offices/clinic/data_models/1/templates/new").to route_to(
        base_params.merge(
          action: 'new',
          data_model_id: '1'
        )
      )
    end

    it 'routes to #show' do
      expect(get: "/offices/clinic/templates/1").to route_to(
        base_params.merge(
          action: 'show',
          id: '1'
        )
      )
    end

    it 'routes to #edit' do
      expect(get: "/offices/clinic/templates/1/edit").to route_to(
        base_params.merge(
          action: 'edit',
          id: '1'
        )
      )
    end

    it 'routes to #create' do
      expect(post: "/offices/clinic/data_models/1/templates").to route_to(
        base_params.merge(
          action: 'create',
          data_model_id: '1'
        )
      )
    end

    it 'routes to #update via PUT' do
      expect(put: "/offices/clinic/templates/1").to route_to(
        base_params.merge(
          action: 'update',
          id: '1'
        )
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: "/offices/clinic/templates/1").to route_to(
        base_params.merge(
          action: 'update',
          id: '1'
        )
      )
    end
  end
end
