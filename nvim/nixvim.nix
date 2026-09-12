{ lib, ... }:
{
  plugins.treesitter = {
  	enable = true;
	settings.ensure_installed = [ "python" "typescript" "nix" "c" "cpp" ];
}
