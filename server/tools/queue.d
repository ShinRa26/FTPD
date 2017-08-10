module server.tools.queue;

import std.stdio;

class Queue(T)
{
public:
    this(){}

    ~this(){}

    // Size of Queue
    @property ulong size()
    {
        return this.queue.length;
    }

    // Checks if the queue is empty
    @property bool isEmpty()
    {
        return this.queue.length == 0;
    }

    // Gets the front element of the queue but does not remove it
    T front()
    {
        if(isEmpty)
        {
            writeln("Queue is empty.");
            return;
        }
        return this.queue[0];
    }

    // Add to queue
    void enqueue(T elem)
    {
        this.queue ~= elem;
    }

    // Remove from queue
    T dequeue()
    {
        if(isEmpty)
        {
            writeln("Queue is empty.");
            return;
        }

        T elem = this.queue[0];
        this.queue = this.queue[1..$];
        return elem;
    }


private:
    T[] queue;
}