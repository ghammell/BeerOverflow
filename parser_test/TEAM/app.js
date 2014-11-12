var markdownParser = (function(){
  return {
    parse: function(text){
      return marked(text)
    }
  }
})()

var markdownController = function(){
  $(".input").on("keyup", function(){
    var text = $('.input').val();
    var parsedText = markdownParser.parse(text);
    markdownView.update(parsedText);
  })
}

var markdownView = (function(){
  return {
    update: function(parsedText){
      $(".preview").html(parsedText);
    }
  }
})()

$(document).ready(function(){
  markdownController();
})
