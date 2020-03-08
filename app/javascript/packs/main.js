$(function() {
  let footerHeight = $("#footer").height();

  $("#content").css("min-height", "calc(100vh - " + footerHeight + "px)");
});
