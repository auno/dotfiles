# vim: set ts=4 sw=4 expandtab:

export PATH="$HOME/.local/bin:$PATH"

# Add Rust to PATH if available
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

