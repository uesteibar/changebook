var BookRetriever = function() {
  this.baseUrl = '/api/books/title';
};

BookRetriever.prototype.fetchAll = function (callback) {
  var request = $.get(this.baseUrl);
  request.done(callback);
};

module.exports = BookRetriever;
