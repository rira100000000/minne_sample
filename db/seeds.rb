# メインのサンプルユーザーを1人作成する
user = User.create!(
             name:  "H&J Gallery",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             postcode: '100-0000',
             address: '東京都千代田区日比谷1-1-1',
             tel: '03-1234-5678',
             receiver_name: 'H&J'
             )
user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/upper_body.jpg')),
                  filename: 'upper_body.jpg')

# 追加のユーザーをまとめて生成する
10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  user = User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
  user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/upper_body.jpg')),
                    filename: 'upper_body.jpg')
end

Order.create!(id:  1,
             title: '子供用にカーキのパンツが欲しい',
             body: '120サイズでなるべく涼しい素材のカーキ色のパンツを探しています。',
             user_id: 2,
             status: 'confirmed')
               
Suggestion.create!(id: 1,
                  title: 'ガーゼ素材子供用パンツ承ります',
                  body: 'ワイドパンツ、ジョガーパンツなど形も多数ございます。記事の参考写真をご覧ください。', 
                  order_id: 1, 
                  user_id: 1,
                  price: 100,
                  deadline: 10,
                  )
Confirm.create!(id: 1,
                order_id: 1,
                suggestion_id: 1,
                postcode: '100-0000',
                address: '東京都千代田区日比谷1-1-1',
                tel: '03-1234-5678',
                receiver_name: '田中太郎')  

Tag.create!(id:2,
            name: 'ファッション')
            
OrderTag.create!(id:2,
                tag_id:2,
                order_id:1)

Tag.create!(id:3,
            name: '子供用')

OrderTag.create!(id:3,
                tag_id:3,
                order_id:1)
                

Order.create!(id:  2,
             title: '小さくてピンク色の植木鉢が欲しい',
             body: '親指サイズくらいのピンク色の植木鉢が欲しいです。',
             user_id: 1
             )
             
Suggestion.create!(id: 2,
                  title: '小さな植木鉢を作っています。',
                  body: '写真の形のものでしたら制作できます。植物の指定も可能です。', 
                  order_id: 2, 
                  user_id: 3,
                  price: 100,
                  deadline: 10,
                  )
   
Suggestion.create!(id: 3,
                  title: 'ミニチュア雑貨の専門店です',
                  body: '植物の写真をいただければミニチュアサイズで制作できます。サイズにて価格が変わります。', 
                  order_id: 2, 
                  user_id: 4,
                  price: 100,
                  deadline: 10,
                  )

Order.create!(id: 3,
             title: 'フィギュアの飾り台が欲しい',
             body: '15cmのフィギュア2体をまとめて飾れる台座が欲しいです。',
             user_id: 1
              )

Order.create!(id:  4,
             title: 'おしゃれな置時計が欲しい',
             body: 'ナチュラルな雰囲気でデスクに置けるサイズの時計を探しています。',
             user_id: 2
             )

Suggestion.create!(id: 4,
                  title: 'シーグラスの置時計はいかがでしょうか',
                  body: '写真は以前うちで制作していたものです。直径10cmほどのものをおつくりできます。', 
                  order_id: 4, 
                  user_id: 1,
                  price: 100,
                  deadline: 10,
                  )

             
Order.create!(id:  5,
             title: '陶器のペアグラスが欲しい',
             body: '両親にプレゼントするためにペアグラスが欲しいです。',
             user_id: 1,
             status: :confirmed
             )

Suggestion.create!(id: 5,
                  title: '陶芸工房です',
                  body: '写真の形のものでしたら制作できます。色などのお好みはありますか？', 
                  order_id: 5, 
                  user_id: 3,
                  price: 100,
                  deadline: 10,
                  )
                  
Confirm.create!(id: 2,
                order_id: 5,
                suggestion_id: 5)  
                
Comment.create!(id: 1, 
                content: '提案ありがとうございます。現在注文すると納期と金額はいくらぐらいになりますか？', 
                user_id: 1, 
                suggestion_id: 2
                )
                
Tag.create!(id:1,
            name: '陶器')

OrderTag.create!(id:1,
                tag_id:1,
                order_id:5)
                
                
Comment.create!(id: 2, 
                content: 'ただいまご注文いただきますと、1週間程度でのお渡しとなります。料金は3000円＋送料となります。', 
                user_id: 2, 
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
                
                
def reset_id(tablename)
  connection = ActiveRecord::Base.connection()
  id = connection.execute("select max(id) from #{tablename}")
  last_id = id[0][0]
  connection.execute( "ALTER SEQUENCE #{tablename}_id_seq RESTART WITH #{last_id} INCREMENT BY 1;")
end

reset_id('orders')
reset_id('suggestions')
reset_id('comments')
reset_id('confirms')
reset_id('order_tags')
reset_id('tags')


