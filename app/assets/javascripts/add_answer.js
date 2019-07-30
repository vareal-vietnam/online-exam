$(document).ready(function() {
  $(document).on("change", "input:checkbox", function() {
    var box = $(this);
    if (box.is(":checked")) {
      box.closest(".answers").find("input:checkbox").prop("checked", false);
      box.prop("checked", true);
    } else {
      box.prop("checked", false);
    }
  });

  var x=0;
  $(".questions")
    .on("cocoon:before-insert", function(e,question_to_be_added) {
      question_to_be_added.fadeIn('slow');
      x++;
      if(x %2 == 0)
        e.preventDefault();
    })
    .on("cocoon:after-insert", function(e, added_question) {
    })
    .on("cocoon:before-remove", function(e, question) {
      $(this).data("remove-timeout", 1000);
      question.fadeOut("slow");
    });
});
