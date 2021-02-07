abstract class BaseSocketAction
  getter socket
  getter context
  getter params

  macro route(path)
        WebSocketHandler.actions.add("socket",{{path}},self)
    end

  def initialize(@socket : HTTP::WebSocket,
                 @context : HTTP::Server::Context,
                 @params : Hash(String, String))
  end

  abstract def new_socket_connected
end
