module server.handlers.file_handler;

import std.stdio, std.string, std.file, std.socket;
import server.tools.clienttools, server.tools.buffertools, server.tools.queue;

class FileHandler
{
public:
    this(Socket c)
    {
        this.client = c;
    }
    ~this(){}

    void fetch(Queue!string fq)
    {
        while(!fq.isEmpty)
        {
            auto filename = fq.dequeue();
        }
    }

    void push(Queue!string pq)
    {
        // [PH]
    }

private:
    Socket client;
    string fetchRootPath = "/files/";
}