$(function(){
  if (window.location.href.match(/\/items\/\d+\/edit/)){

    //プレビューのhtmlを定義
    function buildHTML(count) {
      var html = `<div class="preview-box" id="preview-box__${count}">
                    <div class="upper-box" id="input_image_number_${count}">
                      <img src="" alt="preview">
                    </div>
                    <div class="lower-box">
                      <label class="update-box" for="item_item_images_attributes_${count}_image">
                        <div class="edit_btn">編集</div>
                      </label>
                      <div class="delete-box" id="delete_btn_${count}">
                        <span>削除</span>
                      </div>
                    </div>
                  </div>`
      return html;
    }

    // ラベルのwidth操作
    function setLabel() {
      //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
    }
  
    let firstInputCount = $(".hidden-field").length;
    $('.label-box').attr({id: `label-box--${firstInputCount}`,for: `item_item_images_attributes_${firstInputCount}_image`});
    let editFile = `item_item_images_attributes_${firstInputCount}_image`;
    let addInput = 5 - firstInputCount;
    let inputCount = 0;
    let inputInsert = "";
    let deleteFile = [];
    function inputHtml(input) {
      let html = `<input class="hidden-field" type="file" name="item[item_images_attributes][${input}][image]" id="item_item_images_attributes_${input}_image">`
      return html;
    }
    while (inputCount < addInput) {
      inputInsert += inputHtml(firstInputCount);
      firstInputCount += 1;
      inputCount += 1;
    }
    $(".hidden-content").append(inputInsert);
    setLabel();
    $('.preview-box').each(function(index, box){
        $(box).attr('id', `preview-box__${index}`);
    });
    //削除ボタンにidを追加
    $('.delete-box').each(function(index, box){
      $(box).attr('id', `delete_btn_${index}`);
    });
    $('.update-box').each(function(index, box){
      $(box).attr({
        for: `item_item_images_attributes_${index}_image`,
      });
    });
    $('.upper-box').each(function(index, box){
      $(box).attr("id", `input_image_number_${index}`);
    });
    let count = $('.preview-box').length;
    //プレビューが5あるときは、投稿ボックスを消しておく
    if (count == 5) {
      $('.label-content').hide();
    }



    // プレビューの追加
    $(document).on('change', '.hidden-field', function(e) {
      e.prevertDefault;
      setLabel();
      // MySQLの削除をやめる
      if (deleteFile.length > 0) {
        $(`${deleteFile[0]}`).remove();
      }
      //hidden-fieldのidの数値のみ取得
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //labelボックスのidとforを更新
      $('.label-box').attr({id: `label-box--${id}`,for: `item_item_images_attributes_${id}_image`});
      //選択したfileのオブジェクトを取得
      var file = this.files[0];
      var reader = new FileReader();
      //readAsDataURLで指定したFileオブジェクトを読み込む
      reader.readAsDataURL(file);
      //読み込み時に発火するイベント
      reader.onload = function() {
        var image = this.result;
        // 編集ボタンを押した時 or 新規に登録する時
          //プレビューが元々なかった場合はhtmlを追加
        if ($(`#preview-box__${id}`).length == 0) {
          var count = $('.preview-box').length;
          var html = buildHTML(id);
          //ラベルの直前のプレビュー群にプレビューを追加
          var prevContent = $('.label-content').prev();
          $(prevContent).append(html);
        }
        //イメージを追加
        $(`#preview-box__${id} img`).attr('src', `${image}`);
        var count = $('.preview-box').length;
        //プレビューが5個あったらラベルを隠す 
        if (count == 5) { 
          $('.label-content').hide();
        }

        // MySQL削除履歴を消す
        if (deleteFile.length > 0) {
          deleteFile.shift();
        }

        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        if(count < 5 && deleteFile.length <= 0){
          //プレビューの数でラベルのオプションを更新する
          $('.label-box').attr({id: `label-box--${count}`,for: `item_item_images_attributes_${count}_image`});
        } else if (count < 5 && deleteFile.length > 0) {
          $('.label-box').attr({
            id: `label-box--${deleteFile[0].replace(/[^0-9]/g, '')}`,
            for: `item_item_images_attributes_${deleteFile[0].replace(/[^0-9]/g, '')}_image`
          });
        }
      }
    });

    // 画像の削除
    $(document).on('click', '.delete-box', function(e) {
      e.prevertDefault;
      var count = $('.preview-box').length;
      setLabel(count);
      //item_images_attributes_${id}_image から${id}に入った数字のみを抽出
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //取得したidに該当するプレビューを削除
      $(`#preview-box__${id}`).remove();
      //フォームの中身を削除 
      $(`#item_item_images_attributes_${id}_image`).val("");
      // MySQLに存在する場合、MySQL上のデータを削除
      if ($(`#item_item_images_attributes_${id}_id`).val() > 0) {
        $(".hidden-content").append(
          `<input class="hidden-field" type="hidden" name="item[item_images_attributes][${id}][_destroy]" id="item_item_images_attributes_${id}__destroy" value="1">`
        );
        // MySQL削除履歴
        deleteFile.push(`#item_item_images_attributes_${id}__destroy`);
      }


      //削除時のラベル操作
      var count = $('.preview-box').length;
      //5個めが消されたらラベルを表示
      if (count == 4) {
        $('.label-content').show();
      }
      setLabel(count);

      if(id < 5 && deleteFile.length <= 0){
        //削除された際に、空っぽになったfile_fieldをもう一度入力可能にする
        $('.label-box').attr({id: `label-box--${id}`,for: `item_item_images_attributes_${id}_image`});
      } else {
        $('.label-box').attr({
          id: `label-box--${deleteFile[0].replace(/[^0-9]/g, '')}`,
          for: `item_item_images_attributes_${deleteFile[0].replace(/[^0-9]/g, '')}_image`
        });
      }
    });
  }
});
