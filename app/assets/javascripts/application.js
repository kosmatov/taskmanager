//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap

(function ($) { $(function () {

  $('.stories a.comments').click( function () {

    $(this).parent().parent().children('div.comments').slideToggle();
    return false;
  });
})})(jQuery);
