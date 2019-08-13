$(document).ready(function() {
  $("input[type=text], input[type=email]").focusout(function() {
    $(this).val($.trim($(this).val()));
  });
})
