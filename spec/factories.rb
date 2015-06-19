require 'faker'
FactoryGirl.define do
  factory :source do
    language 'en_US'
    text Faker::Lorem.paragraph(4)
  end

  factory :translation do
    source_id 1
    language %w(de_DE en_GB es_ES fr_FR hi_IN it_IT nb_NO nl_NL pt_PT).sample
    text Faker::Lorem.paragraph(4)
  end
end
