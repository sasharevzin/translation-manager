Fabricator :source do
  text { Faker::Lorem.paragraph }
  language 'en-US'
  translations(count: 1) { |attrs, i| Fabricate.build(:translation) }
end
