require 'rails_helper'

RSpec.describe 'templates/index', type: :view do
  before do
    assign(:templates, [
             Template.create!(
               name: 'Name'
             ),
             Template.create!(
               name: 'Name'
             )
           ])
  end

  it 'renders a list of templates' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
  end
end
