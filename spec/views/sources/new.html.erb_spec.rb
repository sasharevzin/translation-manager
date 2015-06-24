require 'rails_helper'

RSpec.describe 'sources/new', type: :view do
  it 'renders new source form' do
    @source = assign(:source, Source.new)
    assign(:translation, @source.translations.build)
    render

    assert_select 'form[action=?][method=?]', sources_path, 'post' do
      assert_select 'select#source_language[name=?]', 'source[language]'
      assert_select 'textarea#source_text[name=?]', 'source[text]'
      assert_select 'input#source_context[name=?]', 'source[context]'
      assert_select 'select#source_translations_attributes_0_language[name=?]',
                    'source[translations_attributes][0][language]'
      assert_select 'textarea#source_translations_attributes_0_text[name=?]',
                    'source[translations_attributes][0][text]'
    end
  end
end
