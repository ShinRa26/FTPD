module server.tools.buffertools;

/// Convert byte buffer into string
string processBuffer(ubyte[] buffer)
{
    char[] c;
    foreach(b; buffer)
    {
        if(b == 10 || b == 0)
            break;

        c ~= b;
    }

    auto s = cast(string)c;
    return s;
}


/// Clears the buffer
void clearBuffer(ubyte[] buffer){buffer[0..$] = 0x00;}