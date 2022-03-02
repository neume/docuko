require 'rails_helper'

RSpec.describe 'templates/new', type: :view do
  before do
    assign(:template, Template.new(
                        name: 'MyString'
                      ))
  end

  it 'renders new template form' do
    render

    assert_select 'template[action=?][method=?]', templates_path, 'post' do
      assert_select 'input[name=?]', 'template[name]'
    end
  end
end
