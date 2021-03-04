set -l nix_shell_info (
  if test "$IN_NIX_SHELL" = "1"
    echo -n "<nix-shell> "
  end
)
