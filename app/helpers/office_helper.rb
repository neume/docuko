module OfficeHelper
  SORT_ITEMS = [
    { type: :label, name: 'Sort' },
    { type: :option, name: 'Name', code: 'name' },
    { type: :option, name: 'Slug', code: 'slug' }
  ].freeze

  def find_sort_item_by_code(code)
    code ||= 'name'
    SORT_ITEMS.find do |item|
      item[:code] == code
    end
  end

  def office_sort_options
    SORT_ITEMS
  end
end
