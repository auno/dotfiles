# vim: set ts=2 sw=2 expandtab:

zshrc::add_to_path "$HOME/.local/bin"

# Add Rust to PATH if available
if [ -d "$HOME/.cargo/bin" ]; then
  zshrc::add_to_path "$HOME/.cargo/bin"
fi
