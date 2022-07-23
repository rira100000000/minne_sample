function GethashID (hashIDName){
    if(hashIDName){
      $('.tab li').find('a').each(function() {
        var idName = $(this).attr('href');
        if(idName == hashIDName){ 
          var parentElm = $(this).parent();
          $('.tab li').removeClass("active");
          $(parentElm).addClass("active");
          $(".area").removeClass("is-active");
          $(hashIDName).addClass("is-active"); 
        }
      });
    }
  }
$(document).ready(function() {
  $('.tab a').on('click', function() {
    var idName = $(this).attr('href');
    GethashID (idName);
    return false;
  });
})
  $(window).on('load', function () {
      $('.tab li:first-of-type').addClass("active");
      $('#make').addClass("is-active");
    var hashName = location.hash;
    GethashID (hashName);
  });