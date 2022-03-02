require 'rails_helper'

RSpec.describe "forms/index", type: :view do
  before(:each) do
    assign(:forms, [
      Form.create!(
        name: "Name"
      ),
      Form.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of forms" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
