var BookRetriever = require('./book-retriever');

var BookPredictor = function(bookRetriever) {
  this.bookRetriever = bookRetriever;
  this.books
};

BookPredictor.prototype.init = function(selector) {
  this.bookRetriever.fetchAll(function(books) {
    this.books = books;
    console.log(books);
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
      var searchHtml = HandlebarsTemplates['books/search-results']({
        books: [suggestion]
      });
      $('#search-results').html(searchHtml);
    });
  });

  $('#book-search').on('submit', function(event) {
    event.preventDefault();
    this.bookRetriever.search($(selector).val(), function(books) {
      var searchHtml = HandlebarsTemplates['books/search-results']({
        books: books
      });
      $('#search-results').html(searchHtml);
    });
  }.bind(this));

  $('#search-results').on('click', '.select', function(event) {
    event.preventDefault();
    bookId = event.target.dataset.id;
    $('#new-offering').modal('show');
  });
};

module.exports = new BookPredictor(new BookRetriever);
