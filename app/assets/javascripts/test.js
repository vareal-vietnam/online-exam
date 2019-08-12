$(document).ready(function() {
  $(document).on("change", "input:checkbox", function() {
    var box = $(this);
    if (box.is(":checked")) {
      box.closest(".answers").find("input:checkbox").prop("checked", false);
      box.prop("checked", true);
    } else {
      box.prop("checked", false);
      box.closest(".nested-fields .answers").find("input:checkbox").first().prop("checked",true);
    }
  });

  $(".questions")
    .on("cocoon:before-insert", function(e,question_to_be_added) {
      question_to_be_added.fadeIn("slow");
    })
    .on("cocoon:after-insert", function(e, added_question) {
    })
    .on("cocoon:before-remove", function(e, question) {
      $(this).data("remove-timeout", 1000);
      question.fadeOut("slow");
    });

  $(document).on("keypress", "#test_time", function(e){
    if (e.which != 8 && e.which != 0 && e.which < 48 || e.which > 57)
    {
        e.preventDefault();
    }
  });

  var date = new Date();
  date.setSeconds( date.getSeconds() + parseInt($("#time").data("value")) );
  $("#time").countdown({
    until: date,
    layout: "{hn} : {mn} : {sn}",
    onExpiry: function(){
      $(".test-content form").submit();
    }
  });
});
