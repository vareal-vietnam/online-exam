$(document).ready(function() {
  $(".add-question").click(function() {
    var obj = $(this);
    var id = obj.data("id");
    $.ajax ({
      url: "/questions/add/" + id,
      type: "get",
      success: function(data) {
        obj.closest(".form-question").find(".answers").append(data.html);
      }
    });
  });
    $(document).on('change', 'input:checkbox', function() {
      var box = $(this);
      if (box.is(":checked")) {
        box.closest(".a-answer").find("input:checkbox").prop("checked", false);
        box.prop("checked", true);
      } else {
        box.prop("checked", false);
      }
    });
});
