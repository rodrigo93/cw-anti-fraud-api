module RequestSpecHelper
  def parsed_body_response
    JSON.parse(response.body)
  end
end