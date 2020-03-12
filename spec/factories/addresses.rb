FactoryBot.define do

  factory :address do
    sendfirst_name            {"あああ"}
    sendfirst_name_kana       {"カタカナ"}
    sendlast_name             {"あああ"}
    sendlast_name_kana        {"カタカナ"}
    postal_code               {"1111111"}
    prefecture                {"東京都"}
    city                      {"横浜市緑区"}
    address_number            {"青山1-1-1"}
  end

end