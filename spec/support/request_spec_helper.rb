module RequestSpecHelper
  def json_parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end