FactoryGirl.define do
  factory :source do
    language 'en_US'
    text 'Illum quidem repellat iure sequi reprehenderit. Fuga sed amet aut quidem modi. Officia id molestiae omnis. Et cupiditate officia alias dignissimos aut nulla cumque. Et saepe eum quam placeat. Debitis quae magni eos iste id.'
  end

  factory :translation do
    source_id 1
    language %w(de_DE en_GB es_ES fr_FR hi_IN it_IT nb_NO nl_NL pt_PT).sample
    text 'Minus numquam facilis est praesentium quaerat doloribus asperiores. Hic et voluptatum in sit nobis illo. Animi distinctio dolores quaerat. Rerum aperiam velit quia quam perferendis qui quas. Dolor quasi sunt vero. Sint beatae ut excepturi. Quibusdam ipsam facilis quia neque.'
  end
end
