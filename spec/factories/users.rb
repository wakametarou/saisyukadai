FactoryBot.define do

  factory :user do
    first_name            {"あああ"}
    first_name_kana       {"カタカナ"}
    last_name             {"あああ"}
    last_name_kana        {"カタカナ"}
    nickname              {"abe"}
    birthday              {"1980-01-01"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
  end

end