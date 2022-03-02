require 'rails_helper'

RSpec.describe 'forms/show', type: :view do
  before do
    @form = assign(:form, Form.create!(
                            name: 'Name'
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
  end
end
