var BookRetriever = require('./book-retriever');

var BookPredictor = function(bookRetriever) {
  this.bookRetriever = bookRetriever;
};

BookPredictor.prototype.init = function(selector) {
  this.bookRetriever.fetchAll(function(books) {
    var titles = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: books
    });

    titles.initialize();

    var input = $(selector);
    input.typeahead(null, {
      displayKey: 'title',
      source: titles.ttAdapter()
    });

    input.bind('typeahead:select', function(ev, suggestion) {
      console.log(suggestion);
    });

  });
};

module.exports = new BookPredictor(new BookRetriever);
