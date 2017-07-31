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

    // Add to queue
    void enqueue(T elem)
    {
        this.queue ~= elem;
    }

    // Remove from queue
    T dequeue()
    {
        T elem = this.queue[0];
        this.queue = this.queue[1..$];
        return elem;
    }

    // Checks if the queue is empty
    bool isEmpty()
    {
        return this.queue.length == 0;
    }

    // Gets the front element of the queue but does not remove it
    T front()
    {
        return this.queue[0];
    }

private:
    T[] queue;
}