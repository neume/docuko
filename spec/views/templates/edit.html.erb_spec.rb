require 'rails_helper'

RSpec.describe 'templates/edit', type: :view do
  before do
    @template = assign(:template, Template.create!(
                                    name: 'MyString'
                                  ))
  end

  it 'renders the edit template form' do
    render

    assert_select 'template[action=?][method=?]', template_path(@template), 'post' do
      assert_select 'input[name=?]', 'template[name]'
    end
  end
end
