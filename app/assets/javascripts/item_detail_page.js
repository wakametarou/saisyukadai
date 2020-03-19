$(function() {
  let text = $(".column").text();
  let text_fix = text.replace(/\n/, "");
  text = text_fix.replace(/\n/g, "<br>");
  console.log(text);
  $(".column").html(text);

  // 画像切り替え機能
  $(".stock_image").on("click", function(e) {
    e.preventDefault();
    let image = $(this).children("img").attr("src");
    $(".main_image").attr("src", image);
  });
});
