// Flatly
// Bootswatch
//= require jquery
//= require jquery_ujs
//= require flatly/loader
//= require flatly/bootswatch
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require spin.min
$(document).ready(function() {
  var ipAddress = "N/A";
  $.getJSON( "https://api.ipify.org/?format=json", function(data){
    ipAddress = data.ip;
  }).error(function() {
    alert("Error retreving your IP address.");
  });
  $('#search').autocomplete({
    delay: 1000,
    search: function(event, ui) {
        $('#result').empty();
    },
    source: function(request, response) {
      $.getJSON("search.json", { term: request.term, ip_address: ipAddress }, response);
    },
    messages: {
        noResults: 'No results found.',
        results: function() {}
    }
  }).data("ui-autocomplete")._renderMenu = function( ul, items ) {
    console.log("Trigged _renderMenu...")
    var that = this;
    $.each( items, function( index, item ) {
      var el = $($('#article-template').clone());
      el.data('item.autocomplete', item);
      el.show();
      el.find(".title").html(item.title);
      el.find(".description").html(item.description);
      el.find(".photo").html("<img src='"+item.photo.thumb.url+"'/>");
      $('#result').append(el);
    });
    $( ul ).find( "li:odd" ).addClass( "odd" );
  };
});
