redirectToPhoto = function(event, photo_id){
    event.stopPropagation();
    window.location = window.location.origin+"/photos/"+photo_id;
}
