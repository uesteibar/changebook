var Book = function(attributes) {
  this.title = attributes.title;
  this.synopsis = attributes.synopsis;
  this.imageUrl = attributes.imageUrl;
  this.date = attributes.date;
  this.author = attributes.author;
  this.toGiveAway = attributes.toGiveAway;
  this.toExchange = attributes.toExchange;
};

module.exports = Book;
