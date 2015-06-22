require 'rails_helper'

RSpec.describe "sources/index", type: :view do
  let(:sources){2.times.collect{Fabricate(:source)}}

  before(:each) do
    assign(:sources, sources)
  end

  it "renders a list of sources" do
    render
    sources.each do |source|
      assert_select "tr>td", :text => source.id.to_s
      assert_select "tr>td", :text => source.text.to_s
      assert_select "tr>td", :text => source.language.to_s
    end
  end
end
