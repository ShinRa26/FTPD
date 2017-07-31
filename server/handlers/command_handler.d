module server.handlers.command_handler;

import std.string, std.stdio, std.socket;
import server.tools.buffertools, file_handler;

class CommandHandler
{
public:
    this(Socket c)
    {
        this.client = c;
        this.pushQueue = new Queue!string();
        this.fetchQueue = new Queue!string();
        this.fHandler = new FileHandler(this.client);
    }
    ~this(){}

    /// Processes the received message for commands
    void processCmd(string cmd)
    {
        auto split = cmd.split(" ");

        switch(split[0])
        {
            case "fetch":
                processFetch(split[1..$]);
                break;
            case "push":
                processPush(split[1..$]);
                break;
            case "help":
                processHelp(split[1..$]);
                break;
            default:
                sendToClient(this.client, format("Unknown command: %s", split[0]));
                break;
        }
    }

private:
    Socket client;
    ubyte[] buffer = new ubyte[512];
    Queue!string fetchQueue, pushQueue;
    FileHandler fHandler;


    // Processes the fetch command
    void processFetch(string[] args)
    {
        foreach(arg; args)
            this.fetchQueue.enqueue(arg);
        
        this.fHandler.fetch(this.fetchQueue);
    }

    // Processes the push command
    void processPush(string[] args)
    {
        foreach(arg; args)
            this.pushQueue.enqueue(arg);
        this.fHandler.push(this.pushQueue);
    }

    // Processes the help command
    void processHelp(string[] args)
    {
        // [PH]
    }
}