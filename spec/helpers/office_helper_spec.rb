require 'rails_helper'

RSpec.describe OfficeHelper do
  describe '#find_sort_item_by_code' do
    it 'finds sort item' do
      expected = { type: :option, name: 'Slug', code: 'slug' }

      expect(helper.find_sort_item_by_code('slug')).to eq(expected)
    end
  end

  describe 'office_sort_options' do
    it 'returns SORT_ITEMS constant' do
      expect(helper.office_sort_options).not_to be_empty
    end
  end
end
