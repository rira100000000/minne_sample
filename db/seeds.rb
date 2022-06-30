# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

# 追加のユーザーをまとめて生成する
30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

Order.create!(id:  1,
             title: '自分の受けた依頼',
             body: '依頼番号１',
             user_id: 2,
             reciever: 1)
             
Order.create!(id:  2,
             title: '自分の出した依頼',
             body: '依頼番号２',
             user_id: 1 ,
             reciever: 2)

Order.create!(id:  3,
             title: '自分の出した依頼（受注者未定）',
             body: '依頼番号３',
             user_id: 1
              )

Order.create!(id:  4,
             title: '提案中の依頼',
             body: '依頼番号４',
             user_id: 2
             )

             
Suggestion.create!(id: 1,
                  title: '自分にきた提案',
                  body: '提案の内容', 
                  order_id: 2, 
                  user_id: 2
                  )
                  
Suggestion.create!(id: 2,
                  title: '自分のした提案（受注済みのため表示されない）',
                  body: '受注済みのため表示されない', 
                  order_id: 1, 
                  user_id: 1
                  )
                  
Suggestion.create!(id: 3,
                  title: '自分にきた提案',
                  body: '提案の内容', 
                  order_id: 2, 
                  user_id: 3
                  )

Suggestion.create!(id: 4,
                  title: '自分のした提案',
                  body: '提案の内容', 
                  order_id: 4, 
                  user_id: 1
                  )