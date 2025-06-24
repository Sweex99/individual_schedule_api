class Requests::Create
  def initialize(params)
  end

  def call
    serialize_requests
  end

  private

  def serialize_requests
    @requests.map { |request| RequestSerializer.new(request).as_json }
  end

  def scope
    
  end
end
