class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path=="/items/"
      if !!Item.find_by(name: req.path.last)
        returned_item = Item.find_by(name: req.path.last)
        resp.write "#{returned_item.price}"
      else
        resp.write "Item not found"
        resp.status = 400
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
