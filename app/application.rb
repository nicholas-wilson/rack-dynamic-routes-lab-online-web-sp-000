class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.include?("/items/")
      item_name = req.path.split("/items/")
      if !!Item.find_by(name: req.path)
        returned_item = Item.find_by(name: req.path.last)
        resp.write "#{returned_item.price}"
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
