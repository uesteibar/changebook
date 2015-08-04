var BookRetriever = function() {
  this.baseUrl = '/api/v1/books';
};

BookRetriever.prototype.fetchAll = function (callback) {
  var request = $.get(this.baseUrl);
  request.done(callback);
};

BookRetriever.prototype.search = function (term, callback) {
  var request = $.get(this.baseUrl + '/search', {term: term});
  request.done(callback);
};

module.exports = BookRetriever;
