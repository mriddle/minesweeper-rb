require './multiplayer/network_server'

RSpec.describe NetworkServer do
  describe "#start" do
    let(:port) { 123 }
    let(:server_double) { double(TCPServer, accept: socket_double) }
    let(:socket_double) { double(TCPSocket) }

    before { allow(TCPServer).to receive(:new).with(port).and_return(server_double) }

    it "forks with new TCPServer and yields a socket" do
      server = NetworkServer.new(port: port)

      # Bypass the at_exit hook
      allow(server).to receive(:at_exit)

      expect(server).to receive(:fork) do |&fork_block|
        expect do |block|
          fork_block.call(&block).to yield_once_with(TCPSocket)
        end
      end

      server.start
    end
  end

  describe "#ip" do
    before do
      allow(Socket).to receive(:ip_address_list).and_return [
        Addrinfo.new(Socket.sockaddr_in(80, "127.0.0.1")),
        Addrinfo.new(Socket.sockaddr_in(80, "2001:DB8::1")),
        Addrinfo.new(Socket.sockaddr_in(80, "10.1.2.3"))
      ]
    end

    it "returns the first ip that isn't v6 or localhost" do
      server = NetworkServer.new
      expect(server.ip_address).to eq "10.1.2.3"
    end
  end
end
