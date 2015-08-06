require 'rails_helper'

RSpec.describe 'sources/show', type: :view do
  let(:source) { Fabricate(:source) }

  it 'renders a list of sources' do
    assign(:source, source)
    render

    expect(rendered).to match source.text
    expect(rendered).to match source.language

    expect(rendered).to have_selector('table tr td',
                                      text: source.translations.first.language.to_s)
    expect(rendered).to have_selector('table tr td',
                                      text: source.translations.first.text.to_s)
  end
end
