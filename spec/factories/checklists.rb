FactoryBot.define do
  factory :checklist do
    order_id { 1 }
    order_day { "MyString" }
    order_status { "MyString" }
    payment_type { "MyString" }
    payment_day { "MyString" }
    send_day { "MyString" }
    item_name { "MyString" }
    send_type { "MyString" }
    send_area { "MyString" }
    dead_line { "MyString" }
    item_price { 1 }
    quantity { 1 }
    item_total_price { 1 }
    note { "MyString" }
    total_price { 1 }
    send_price { 1 }
    all_total_price { 1 }
    user_id { "MyString" }
    nickname { "MyString" }
    use_name { "MyString" }
    user_tel { "MyString" }
    post_number { "MyString" }
    address1 { "MyString" }
    address2 { "MyString" }
    sending_name { "MyString" }
    sending_tel { "MyString" }
    item_id { "MyString" }
  end
end
