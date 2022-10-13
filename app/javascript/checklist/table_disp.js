let fileInput = document.getElementById('csv_file');
let message = document.getElementById('message');
let fileReader = new FileReader();

// ファイル変更時イベント
fileInput.onchange = () => {
  message.innerHTML = "読み込み中..."

  let file = fileInput.files[0];
  fileReader.readAsText(file);
};

// ファイル読み込み時
let items = [];
fileReader.onload = () => {
  // ファイル読み込み
  let fileResult = fileReader.result.split('\n');

  // 先頭行をヘッダとして格納
  let header = fileResult[0].split(',')
  // 先頭行の削除
  fileResult.shift();

  // CSVから情報を取得
  items = fileResult.map(item => {
    let datas = item.split(',');
    let result = {};
    for (const index in datas) {
      let key = header[index];
      result[key] = datas[index];
    }
    return result;
  });

  //　CSVの内容を表示
  items.pop();
  valueChange();
  message.innerHTML = items.length + "件のデータを読み込みました。"
}

// ファイル読み取り失敗時
fileReader.onerror = () => {
  items = [];
  message.innerHTML = "ファイル読み取りに失敗しました。"
}

//チェックボックス処理
function valueChange(event){
  let tbody = document.querySelector('#csv_data_table tbody');
  let thead = document.querySelector('#csv_data_table thead');
  tbody.innerHTML = "";
  thead.innerHTML = "";
  let tbody_html = "";
  let thead_html = "";
  let address ='';

  //ヘッダ
  if (order_id.checked){thead_html += `<th>注文ID</th>`}
  if (order_day.checked){thead_html += `<th>注文日</th>`}
  if (order_status.checked){thead_html += `<th>注文状況</th>`}
  if (payment_type.checked){thead_html += `<th>支払方法</th>`}
  if (payment_day.checked){thead_html += `<th>入金確認日</th>`}
  if (send_day.checked){thead_html += `<th>発送日</th>`}
  if (item_name.checked){thead_html += `<th>作品名</th>`}
  if (send_type.checked){thead_html += `<th>配送方法</th>`}
  if (send_area.checked){thead_html += `<th>配送エリア</th>`}
  if (dead_line.checked){thead_html += `<th>発送までの目安</th>`}
  if (item_price.checked){thead_html += `<th>販売価格</th>`}
  if (quantity.checked){thead_html += `<th>数量</th>`}
  if (item_total.checked){thead_html += `<th>小計</th>`}
  if (note.checked){thead_html += `<th>備考</th>`}
  if (total_price.checked){thead_html += `<th>注文の販売価格</th>`}
  if (send_price.checked){thead_html += `<th>注文の送料</th>`}
  if (all_total_price.checked){thead_html += `<th>注文の合計</th>`}
  if (user_id.checked){thead_html += `<th>注文者のユーザーID</th>`}
  if (nickname.checked){thead_html += `<th>注文者のニックネーム</th>`}
  if (use_name.checked){thead_html += `<th>注文者の氏名</th>`}
  if (user_tel.checked){thead_html += `<th>注文者の電話番号</th>`}
  if (address1.checked){thead_html += `<th>配送先の住所</th>`}
  if (sending_name.checked){thead_html += `<th>配送先の氏名</th>`}
  if (sending_tel.checked){thead_html += `<th>配送先の電話番号</th>`}
 // if (item_id.checked){thead_html += `<th>作品管理番号</th>`}

  for (item of items) {
    
    if(pending.checked){
      if (item.注文状況 !='発送準備中'){continue;}
    }
    
    disp_data = data_sort(item);
    posnum = disp_data[0];
    address = disp_data[1];
    disp_note =disp_data[2];
    
    tbody_html += '<tr>'
   //内容
    if (order_id.checked){tbody_html += `<td>${item.注文ID}</td>`}
    if (order_day.checked){tbody_html += `<td>${item.注文日}</td>`}
    if (order_status.checked){tbody_html += `<td>${item.注文状況}</td>`}
    if (payment_type.checked){tbody_html += `<td>${item.支払方法}</td>`}
    if (payment_day.checked){tbody_html += `<td>${item.入金確認日}</td>`}
    if (send_day.checked){tbody_html += `<td>${item.発送日}</td>`}
    if (item_name.checked){tbody_html += `<td>${item.作品名}</td>`}
    if (send_type.checked){tbody_html += `<td>${item.配送方法}</td>`}
    if (send_area.checked){tbody_html += `<td>${item.配送エリア}</td>`}
    if (dead_line.checked){tbody_html += `<td>${item.発送までの目安}</td>`}
    if (item_price.checked){tbody_html += `<td>${item.販売価格}</td>`}
    if (quantity.checked){tbody_html += `<td>${item.数量}</td>`}
    if (item_total.checked){tbody_html += `<td>${item.小計}</td>`}
    if (note.checked){tbody_html += `<td>${disp_note}</td>`}
    if (total_price.checked){tbody_html += `<td>${item.注文の販売価格}</td>`}
    if (send_price.checked){tbody_html += `<td>${item.注文の送料}</td>`}
    if (all_total_price.checked){tbody_html += `<td>${item.注文の合計}</td>`}
    if (user_id.checked){tbody_html += `<td>${item.注文者のユーザーID}</td>`}
    if (nickname.checked){tbody_html += `<td>${item.注文者のニックネーム}</td>`}
    if (use_name.checked){tbody_html += `<td>${item.注文者の氏名}</td>`}
    if (user_tel.checked){tbody_html += `<td>${item.注文者の電話番号}</td>`}
    if (address1.checked){tbody_html += `<td>${posnum}<br>${address}</td>`}
    if (sending_name.checked){tbody_html += `<td>${item.配送先の氏名}</td>`}
    if (sending_tel.checked){tbody_html += `<td>${item.配送先の電話番号}</td>`}
//    if (item_id.checked){tbody_html += `<td>${item.作品管理番号}</td>`}

    tbody_html += '</tr>'
  }
  tbody.innerHTML = tbody_html;
  thead.innerHTML = thead_html;
}

function data_sort(item){
    buf = item.配送先の郵便番号 ;
    posnum = '〒' + String(buf).slice(0,3) + '-' + String(buf).slice(3,7);
    address = item.配送先の住所1 ;
    if(item.配送先の住所2 != '""'){address = address + item.配送先の住所2}
    disp_note ="";
    if(item.備考 != '""'){disp_note = item.備考};
    return [posnum,address,disp_note]
}

$(function(){
  //印刷ボタンをクリックした時の処理
  $('.print-btn').on('click', function(){
  
  //プリントしたいエリアの取得
  var printArea = document.getElementsByClassName("print-area");
  
  //プリント用の要素「#print」を作成し、上で取得したprintAreaをその子要素に入れる。
  $('body').append('<div id="print" class="printBc"></div>');
  $(printArea).clone().appendTo('#print');
  
  //プリントしたいエリア意外に、非表示のcssが付与されたclassを追加
  $('body > :not(#print)').addClass('print-off');
  var unprint_area = document.getElementsByClassName('print-off')
  for( let i = 0 ; i < unprint_area.length ; i ++ ) {
    $(unprint_area)[i].style.display = 'none';
  }
  window.print();
  for( let i = 0 ; i < unprint_area.length ; i ++ ) {
    if($(unprint_area)[i].id == 'css_page'){continue};
    $(unprint_area)[i].style.display = "flex";
    
  }

  //window.print()を実行した後、作成した「#print」と、非表示用のclass「print-off」を削除


  $('#print').remove();
  $('.print-off').removeClass('print-off');

 });
});



let order_id= document.getElementById('order_id');
let order_day= document.getElementById('order_day');
let order_status= document.getElementById('order_status');
let payment_type= document.getElementById('payment_type');
let payment_day= document.getElementById('payment_day');
let send_day= document.getElementById('send_day');
let item_name= document.getElementById('item_name');
let send_type= document.getElementById('send_type');
let send_area= document.getElementById('send_area');
let dead_line= document.getElementById('dead_line');
let item_price= document.getElementById('item_price');
let quantity= document.getElementById('quantity');
let item_total= document.getElementById('item_total');
let note= document.getElementById('note');
let total_price= document.getElementById('total_price');
let send_price= document.getElementById('send_price');
let all_total_price= document.getElementById('all_total_price');
let user_id= document.getElementById('user_id');
let nickname= document.getElementById('nickname');
let use_name= document.getElementById('use_name');
let user_tel= document.getElementById('user_tel');
//let post_number= document.getElementById('post_number');
let address1= document.getElementById('address1');
//let address2= document.getElementById('address2');
let sending_name= document.getElementById('sending_name');
let sending_tel= document.getElementById('sending_tel');
//let item_id= document.getElementById('item_id');
let pending= document.getElementById('pending');

order_id.addEventListener('change', valueChange);
order_day.addEventListener('change', valueChange);
order_status.addEventListener('change', valueChange);
payment_type.addEventListener('change', valueChange);
payment_day.addEventListener('change', valueChange);
send_day.addEventListener('change', valueChange);
item_name.addEventListener('change', valueChange);
send_type.addEventListener('change', valueChange);
send_area.addEventListener('change', valueChange);
dead_line.addEventListener('change', valueChange);
item_price.addEventListener('change', valueChange);
quantity.addEventListener('change', valueChange);
item_total.addEventListener('change', valueChange);
note.addEventListener('change', valueChange);
total_price.addEventListener('change', valueChange);
send_price.addEventListener('change', valueChange);
all_total_price.addEventListener('change', valueChange);
user_id.addEventListener('change', valueChange);
nickname.addEventListener('change', valueChange);
use_name.addEventListener('change', valueChange);
user_tel.addEventListener('change', valueChange);
//post_number.addEventListener('change', valueChange);
address1.addEventListener('change', valueChange);
//address2.addEventListener('change', valueChange);
sending_name.addEventListener('change', valueChange);
sending_tel.addEventListener('change', valueChange);
//item_id.addEventListener('change', valueChange);
pending.addEventListener('change', valueChange);