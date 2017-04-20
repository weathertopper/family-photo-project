redirectToMemory = function(event, memory_id){
    event.stopPropagation();
    window.location = window.location.origin+"/memories/"+memory_id;
}
