require 'socket'

class NetworkServer
  def initialize(port: 9898)
    @port = port
  end

  def start
    raise "Server already started!" if @server_pid

    @server_pid = fork do
      server = TCPServer.new @port
      socket = server.accept
      yield socket
      socket.close
    end

    # Ensure we kill the forked process if it's
    # still running and the main process terminates
    at_exit { shutdown if @server_pid }
  end

  private

  def shutdown
    Process.kill(:SIGTERM, @server_pid)
    Process.wait2(@server_pid)
    @server_pid = nil
  end
end
