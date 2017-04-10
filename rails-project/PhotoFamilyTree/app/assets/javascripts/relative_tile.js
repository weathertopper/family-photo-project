

// $(document).on('turbolinks:load', function(){
//     //  this shit doesn't work
// });

infoClick = function(event,  relative_name ){
    event.stopPropagation();
    alert(relative_name);
    $('.overlay-panel').attr('class', 'overlay-panel show-tree');
}

displayFamilyBranches = function(event, family_tree){
    event.stopPropagation();
    $(".relation-value").text("");
    family_tree = JSON.parse(family_tree);
    $(".relation-value").each(function(index){
        var id = $(this).attr('id');
        var relation_title = family_tree[id];
        $(this).text(relation_title);
    })
    $('.overlay-panel').attr('class', 'overlay-panel show-tree');
}

redirectToRelative = function(event, relative_id){
    event.stopPropagation();
    window.location = window.location.origin+"/relatives/"+relative_id;
}

$(window).click(function(event){
    event.stopPropagation();
    $(".relation-value").text("");
    $('.overlay-panel.show-tree').attr('class', 'overlay-panel');
})
