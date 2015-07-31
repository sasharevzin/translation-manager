Fabricator :source do
  text Faker::Lorem.paragraph
  language 'en-US'
  translations(count: 1) { |attrs, i| Fabricate.build(:translation) }

  # after_build do |source|
  #   translation = Fabricate(:translation)
  #   source.translations << translation
  # end
end
