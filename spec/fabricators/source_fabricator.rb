Fabricator :source do
  text Faker::Lorem.paragraph
  language 'en-US'
  after_build do |source|
    translation = Fabricate(:translation)
    source.translations << translation
  end
end