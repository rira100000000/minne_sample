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
             title: '子供用にカーキのパンツが欲しい',
             body: '120サイズでなるべく涼しい素材のカーキ色のパンツを探しています。',
             user_id: 2,
             reciever: 1)
             
Order.create!(id:  2,
             title: '小さくてピンク色の植木鉢が欲しい',
             body: '親指サイズくらいのピンク色の植木鉢が欲しいです。',
             user_id: 1 ,
             reciever: 2)

Order.create!(id:  3,
             title: 'フィギュアの飾り台が欲しい',
             body: '15cmのフィギュア2体をまとめて飾れる台座が欲しいです。',
             user_id: 1
              )

Order.create!(id:  4,
             title: 'おしゃれな置時計が欲しい',
             body: 'ナチュラルな雰囲気でデスクに置けるサイズの時計を探しています。',
             user_id: 2
             )

             
Suggestion.create!(id: 1,
                  title: '小さな植木鉢を作っています。',
                  body: '写真の形のものでしたら制作できます。植物の指定も可能です。', 
                  order_id: 2, 
                  user_id: 3
                  )
                  
Suggestion.create!(id: 2,
                  title: 'ガーゼ素材子供用パンツ承ります',
                  body: 'ワイドパンツ、ジョガーパンツなど形も多数ございます。記事の参考写真をご覧ください。', 
                  order_id: 1, 
                  user_id: 1
                  )
                  
Suggestion.create!(id: 3,
                  title: 'ミニチュア雑貨の専門店です',
                  body: '植物の写真をいただければミニチュアサイズで制作できます。サイズにて価格が変わります。', 
                  order_id: 2, 
                  user_id: 4
                  )

Suggestion.create!(id: 4,
                  title: 'シーグラスの置時計はいかがでしょうか',
                  body: '写真は以前うちで制作していたものです。直径10cmほどのものをおつくりできます。', 
                  order_id: 4, 
                  user_id: 1
                  )
                  
Comment.create!(id: 1, 
                content: '提案ありがとうございます。現在注文すると納期と金額はいくらぐらいになりますか？', 
                user_id: 2, 
                suggestion_id: 2
                )
                
Comment.create!(id: 2, 
                content: 'ただいまご注文いただきますと、1週間程度でのお渡しとなります。料金は3000円＋送料となります。', 
                user_id: 1, 
                suggestion_id: 2
                )

Comment.create!(id: 3, 
                content: 'ピンクがご希望ということでしたので色見本用意いたしました。ご覧ください。', 
                user_id: 3, 
                suggestion_id: 1
                )
                
Comment.create!(id: 4, 
                content: 'ありがとうございます。検討させていただきます。', 
                user_id: 1, 
                suggestion_id: 1
                )