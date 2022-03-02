require 'rails_helper'

RSpec.describe 'templates/show', type: :view do
  before do
    @template = assign(:template, Template.create!(
                                    name: 'Name'
                                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
  end
end
