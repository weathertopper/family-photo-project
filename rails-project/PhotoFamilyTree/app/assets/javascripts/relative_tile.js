

$(document).on('turbolinks:load', function(){
//$(document).on('turbolinks:load ready', function(){
    //  set up relative column sizes based on image
    $(".thumbnail").each(function(index){
        if ($(".profile-pic").get(index).height < $(".profile-pic").get(index).width){ //landscape
            $(this).addClass('col-xs-6 col-sm-4 col-md-3 col-lg-3 col-xl-3');
        }
        else{
            $(this).addClass('col-xs-6 col-sm-4 col-md-2 col-lg-2 col-xl-2');
        }
    })
    $('.thumbnail').show();
});

infoClick = function(event,  relative_name ){
    event.stopPropagation();
    alert(relative_name);
    $('.overlay-panel').attr('class', 'overlay-panel show-tree');
}

displayFamilyBranches = function(event, family_tree){
    event.stopPropagation();
    console.log("fam tree "+family_tree);
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
    $('.overlay-panel.show-tree').attr('class', 'overlay-panel');
})
