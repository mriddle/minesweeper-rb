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
end
