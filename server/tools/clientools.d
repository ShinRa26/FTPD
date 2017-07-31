    module server.tools.clienttools;

    import std.socket;
    import server.tools.buffertools;
    
    // Send message to client
    void sendToClient(Socket client, string msg)
    {
        client.send(msg);
    }

    // Receive a message from the client
    string receiveFromClient(Socket client, ubyte[] buffer)
    {
        const auto recv = client.receive(buffer);
        if(recv == -1 || recv == 0)
            return null;
        
        auto msg = processBuffer(buffer);
        clearBuffer(buffer);
        return msg;
    }