class HTTP::WebSocket
  property partners : Array(HTTP::WebSocket) = [] of HTTP::WebSocket
end

class ChatRooms::Access < BaseSocketAction
  route "/rooms"
  class_property sockets : Array(HTTP::WebSocket) = [] of HTTP::WebSocket

  def new_socket_connected
    self.class.sockets << socket

    socket.send({
      connected: socket.object_id.to_s,
    }.to_json)

    socket.on_message do |message|
      json = Hash(String, JSON::Any).from_json(message)
      receiver = json["receiver"]
      if receiver.raw.is_a? Nil
        next
      end
      json["sender"] = JSON::Any.new(socket.object_id.to_s)
      target_socket = self.class.sockets.find { |s| s.object_id.to_s == receiver }
      target_socket.try &.send(json.to_json)
    end

    socket.on_close do
        ChatRooms::Access.sockets.delete socket
        ChatRooms::Access.sockets.each &.send({
          closed: socket.object_id,
        }.to_json)
    end
  end
end

Fiber.yield