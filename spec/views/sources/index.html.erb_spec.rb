require 'rails_helper'

RSpec.describe "sources/index", type: :view do
  let(:sources){2.times.collect{Fabricate(:source)}}

  it "renders a list of sources" do
    assign(:sources, sources)
    render

    sources.each do |source|
      expect(rendered).to have_selector("table tr td", text: source.id.to_s)
      expect(rendered).to have_selector("table tr td", text: source.text.to_s)
      expect(rendered).to have_selector("table tr td", text: source.language.to_s)
    end
  end
end
