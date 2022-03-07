# Application Service Helper for Faraday connections

class ApplicationService
  def self.conn(url)
    Faraday.new(url: url)
  end

  def self.json_parse(response_body)
    JSON.parse(response_body, symbolize_names: true)
  end
end
