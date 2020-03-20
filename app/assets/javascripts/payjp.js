document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_cc8194b2b897885b090c8c89"); //ここに公開鍵を直書き
      let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得されます
      btn.addEventListener("click", e => { //ボタンが押されたときに作動します
        e.preventDefault(); //ボタンを一旦無効化します
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        }; //入力されたデータを取得します。
        Payjp.createToken(card, (status, response) => {
          if (status === 200) { //成功した場合
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            ); //取得したトークンを送信できる状態にします
            document.inputForm.submit();
            alert("登録が完了しました"); //確認用
          } else {
            alert("カード情報が正しくありません。"); //確認用
          }
        });
      });
    }
  },
  false
);

// $(document).on('turbolinks:load',function(){
//   // PAY.JPの公開鍵をセットします。
//   Payjp.setPublicKey('pk_test_cc8194b2b897885b090c8c89');

//   //formのsubmitを止めるために, クレジットカード登録のformを定義します。
//   var form = $(".form");

//   $("#charge-form").click(function() {
//     // submitが完了する前に、formを止めます。
//     form.find("input[type=submit]").prop("disabled", true);
//     // submitを止められたので、PAY.JPの登録に必要な処理をします。

//     // formで入力された、カード情報を取得します。
//     var card = {
//       number: $("#card_number").val(),
//       cvc: $("#cvc").val(),
//       exp_month: $("#exp_month").val(),
//       exp_year: $("#exp_year").val(),
//     };

//     // PAYJPに登録するためのトークン作成
//     Payjp.createToken(card, function(status, response) {
//       if (response.error){
//         // エラーがある場合処理しない。
//         form.find('.payment-errors').text(response.error.message);
//         form.find('button').prop('disabled', false);
//       }   
//       else {
//         // エラーなく問題なく進めた場合
//         // formで取得したカード情報を削除して、Appにカード情報を残さない。
//         $("#card_number").removeAttr("name");
//         $("#cvc").removeAttr("name");
//         $("#exp_month").removeAttr("name");
//         $("#exp_year").removeAttr("name");
//         var token = response.id;
//         form.append($('<input type="hidden" name="payjpToken" />').val(token));
//         form.get(0).submit();
//       };
//     });
//   });
// });
// コントローラーの記述