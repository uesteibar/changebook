class ElasticsearchClientAdapter
  def initialize(index)
    if ENV['SEARCHBOX_SSL_URL']
      @client = Elasticsearch::Client.new host: ENV['SEARCHBOX_SSL_URL']
    else
      @client = Elasticsearch::Client.new log: true
    end
    @index = index
  end

  def search(type:, body:, size:)
    @client.search index: @index, type: type, size: size, body: body
  end

  def index(type:, id:, body:)
    @client.index index: @index, type: type, id: id, body: body
  end
end
