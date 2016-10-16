$( document ).ready(function() {

    $("#source").sortable({connectWith: "#dropbox"});

    $("#dropbox").sortable({
        connectWith: "#source",
        update: function(event, ui) {
            var pageOrder = $(this).sortable('toArray').toString();
            $("#pages").val(pageOrder);
        }
    });

});
