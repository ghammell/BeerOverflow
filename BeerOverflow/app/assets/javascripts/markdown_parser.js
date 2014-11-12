var markdownParser = (function(){
  return {
    parse: function(text){
      return marked(text)
    }
  }
})()

var markdownView = (function(){
  return {
    update: function(parsedText, parsedContainer){
      $(parsedContainer).html(parsedText);
    }
  }
})()

var markdownController = function(markdownSelector, parsedContainer){
  $(markdownSelector).on("keyup", function(){
    var text = $(markdownSelector).val();
    var parsedText = markdownParser.parse(text);
    markdownView.update(parsedText, parsedContainer);
  })
}

var convertText = function(convertSelector) {
  $(convertSelector).each( function(index, element) {
    markedText = marked($(element).text())
    $(element).html(markedText)
  })
}
