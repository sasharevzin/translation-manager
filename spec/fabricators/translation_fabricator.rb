Fabricator :translation do
  text Faker::Lorem.paragraph
  language { [:pt, :es, :fr].sample }
end
