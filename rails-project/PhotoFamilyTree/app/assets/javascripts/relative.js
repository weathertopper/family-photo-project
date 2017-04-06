$(document).on('turbolinks:load', function(){
    var max_width = $('.foreground').width();
    $('body').width(max_width);
});
