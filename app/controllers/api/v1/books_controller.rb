module Api
  module V1
    class BooksController < ApplicationController
      def search
        limit = params[:limit] || 10
        books = Book.search_by_title(params[:term]).limit(limit)

        results = books.map do |book|
          {}.tap do |book_hash|
            book_hash[:id] = book.id
            book_hash[:title] = book.title
            book_hash[:author] = book.author
            book_hash[:genre] = book.genre
            book_hash[:cover_url] = book.cover.url
          end
        end

        render status: 200, json: results
      end

      def search_complex
        limit = params[:limit] || 10
        books = BooksElasticsearch.new.search(params[:term], limit)

        results = books.map do |book|
          {}.tap do |book_hash|
            book_hash[:id] = book.id
            book_hash[:title] = book.title
            book_hash[:author] = book.author
            book_hash[:genre] = book.genre
            book_hash[:cover_url] = book.cover.url
          end
        end

        render status: 200, json: results
      end

      def index
        books = Book.all

        results = books.map do |book|
          {}.tap do |book_hash|
            book_hash[:id] = book.id
            book_hash[:title] = book.title
            book_hash[:author] = book.author
            book_hash[:genre] = book.genre
            book_hash[:cover_url] = book.cover.url
          end
        end
        render status: 200, json: results
      end
    end
  end
end
