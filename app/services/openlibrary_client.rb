class OpenlibraryClient
  def search_book(search_params)
    client = Openlibrary::Client.new
    results = client.search(search_params)

    normalize_book(results)
  end

  private

  def normalize_book(results)
    view_client = Openlibrary::View
    book_view = view_client.find_by_isbn(results.first.isbn.last)
    Book.new(
      title: results.first.title,
      author: results.first.author_name.first,
      image_url: book_view.thumbnail_url
    )
  end
end
