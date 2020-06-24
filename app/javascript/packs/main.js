import "bootstrap/js/dist/tooltip";

$(document).on("turbolinks:load", function() {
  let footerHeight = $("#footer").outerHeight();
  let headerHeight = $("#header").outerHeight();
  let totalHeight = footerHeight + headerHeight;

  $("#content").css("min-height", "calc(100vh - " + totalHeight + "px)");
  $("[data-toggle='tooltip']").tooltip();
});
