module server.ftp_server;

import core.thread;
import std.stdio, std.socket;
import server.tools.buffertools;

TcpSocket server;
ushort port = 9000;

void main(string[] args)
{
    server = new TcpSocket();
    scope(exit)
    {
        server.shutdown(SocketShutdown.BOTH);
        server.close();
    }

    assert(server.isAlive);
    server.blocking = true;
    server.bind(new InternetAddress(port));
    writefln("Server online!\nListening on port: %d...\n", port);
    server.listen(1);

    /// Listen for new connections
    while(true)
    {
        auto h = new Handler(server.accept());
        h.start();
    }
}

/// Handler for multi client access
class Handler : Thread
{
public:
    this(Socket c)
    {
        super(&run);
        this.client = c;
        this.cHandler = new CommandHandler(this.client);
    }

    /// Ensures client is closed and shutdown before destruction
    ~this()
    {
        this.client.close();
        this.client.shutdown(SocketShutdown.BOTH);
    }

private:
    Socket client;
    CommandHandler cHandler;
    ubyte[] buffer = new ubyte[512];

    void run()
    {
        auto message = "FTP Server v0.0.1\n\nfetch [file(s)] or push [file(s)]\n\n";
        sendToClient(this.client, message);

        while(true)
        {
            sendToClient("#~> ");
            auto msg = receiveFromClient(this.client, this.buffer);
            if(msg is null)
            {
                writefln("Client disconnected.");
                break;
            }

            this.cHandler.processCmd(msg);
        }

        destroy(this);
    }
}