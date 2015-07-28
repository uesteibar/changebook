var Book = require('./book');

var BookInfoRetriever = function(apiAdapter) {
  this.apiAdapter = apiAdapter;
  this.baseUrl = '/books/search';
};

BookInfoRetriever.prototype.searchByTitle = function (params, callback) {
  var request = $.get(this.baseUrl, params);
  request.done(function(bookJSON) {
    console.log(bookJSON);
  });
};

module.exports = BookInfoRetriever;
