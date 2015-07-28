var BookRetriever = require('./book-retriever');

var bookId = -1;

var BookPredictor = function(bookRetriever) {
  this.bookRetriever = bookRetriever;
  this.books
};

BookPredictor.prototype.init = function(selector) {
  this.bookRetriever.fetchAll(function(books) {
    this.books = books;
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

  $('#search-results').on('click', '#new-book', function(event) {
    event.preventDefault();
    $('#create-book').modal('show');
  });

  $('#new-offer').on('submit', function(event) {
    event.preventDefault();
    inputs = $(event.target).serializeArray();
    var params = {
      book_id: bookId
    };

    inputs.forEach(function(input) {
      if (input.name == 'to-give-away') {
        params.to_give_away = true;
      } else if (input.name == 'to-exchange') {
        params.to_exchange = true;
      }
    });

    var request = $.post('/ownerships', {
      ownership: params
    });
    request.done(function(res) {
      window.location.path = '/';
    });
  });

  $('body').on('submit', '.new-book', function(event) {
    event.preventDefault();
    $('#create-book').modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
  });

};

module.exports = new BookPredictor(new BookRetriever);
