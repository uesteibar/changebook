class ElasticsearchClientAdapter
  def initialize(index)
    if ENV['SEARCHBOX_SSL_URL']
      @client = Elasticsearch::Client.new host: ENV['SEARCHBOX_SSL_URL']
    else
      @client = Elasticsearch::Client.new log: true
    end
    @index = index
  end

  def search(type: type, body: body, size: size)
    @client.search index: @index, type: type, size: size, body: body
  end

  def index(type: type, id: id, body: body)
    @client.index index: @index, type: type, id: id, body: body
  end
end
