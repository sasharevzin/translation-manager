require 'rails_helper'

RSpec.describe 'sources/index', type: :view do
  before do
    2.times.collect { Fabricate(:source) }
  end

  it 'renders a list of sources' do
    # Because of paging view expects an ActiveRecord::Relation
    sources = Source.paginate(page: 1)
    assign(:sources, sources)

    render

    sources.each do |source|
      expect(rendered).to match source.text
      expect(rendered).to match source.language
    end
  end
end
