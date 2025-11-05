#!/bin/bash

# Kill processes on ports 3000 and 3001

echo "🧹 Cleaning up ports 3000 and 3001..."

# Function to kill process on a specific port
kill_port() {
    local port=$1
    local pid=$(lsof -ti:$port)
    
    if [ ! -z "$pid" ]; then
        echo "Killing process $pid on port $port"
        kill -9 $pid 2>/dev/null
        sleep 1
        
        # Verify the process is killed
        if lsof -ti:$port >/dev/null 2>&1; then
            echo "⚠️ Warning: Process on port $port might still be running"
        else
            echo "✅ Port $port is now free"
        fi
    else
        echo "✅ Port $port is already free"
    fi
}

# Kill processes on both ports
kill_port 3000
kill_port 3001

echo "🎉 Port cleanup completed!"