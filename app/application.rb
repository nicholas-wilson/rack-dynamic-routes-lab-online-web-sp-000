class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.include?("/items/")
      item_name = req.path.split("/items/")
      puts item_name
      if !!Item.find_by_name(item_name)
        returned_item = Item.find_by_name(item_name)
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
