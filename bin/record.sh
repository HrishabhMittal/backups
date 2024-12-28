#!/usr/bin/env bash

# Temporary file to hold input commands
INPUT_SCRIPT=$(mktemp)

# Function to clean up on exit
cleanup() {
  echo "Stopping recording..."
  echo "record-save" >> "$INPUT_SCRIPT"  # Command to save the recording
  echo "quit" >> "$INPUT_SCRIPT"        # Command to exit SimpleScreenRecorder
  sleep 2  # Allow time for saving
  kill "$SCRIPT_PID" &> /dev/null      # Kill the `script` process
  rm -f "$INPUT_SCRIPT"                # Remove temporary input file
  echo "Recording saved and script cleaned up."
  exit 0
}

# Start SimpleScreenRecorder inside a pseudo-terminal
trap cleanup SIGINT
script -qefc "simplescreenrecorder --start-recording --start-hidden --no-redirect-stderr" "$INPUT_SCRIPT" &
SCRIPT_PID=$!

# Wait for the user to press Ctrl+C
echo "Recording started. Press Ctrl+C to save and exit."
wait "$SCRIPT_PID"
