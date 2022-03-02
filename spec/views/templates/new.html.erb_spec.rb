require 'rails_helper'

RSpec.describe 'forms/new', type: :view do
  before do
    assign(:form, Form.new(
                    name: 'MyString'
                  ))
  end

  it 'renders new form form' do
    render

    assert_select 'form[action=?][method=?]', forms_path, 'post' do
      assert_select 'input[name=?]', 'form[name]'
    end
  end
end
