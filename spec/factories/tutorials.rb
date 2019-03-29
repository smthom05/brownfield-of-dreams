FactoryBot.define do
  factory :tutorial do
    title { Faker::Name.unique.name }
    description { Faker::HitchhikersGuideToTheGalaxy.marvin_quote }
    thumbnail {
      'http://cdn3-www.dogtime.com/' \
      'assets/uploads/2011/03/puppy-development-460x306.jpg'
    }
    playlist_id { Faker::Crypto.md5 }
    classroom { false }
  end
end
