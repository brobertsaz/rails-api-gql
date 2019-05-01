 module JsonHelper
  def json
    JSON.parse(response.body) rescue {}
  end
end
