{ config, pkgs, ... }: 
let
	gruvboxplus = import ./gruvbox-plus.nix { inherit pkgs; };
in
{
	gtk.enable = true;
	
	gtk.cursorTheme.package = pkgs.bibata-cursors;
	gtk.cursorTheme.name = "Bibata-Modern-Classic";
	
	gtk.theme.package = pkgs.gruvbox-dark-gtk;
	gtk.theme.name = "gruvbox-dark-gtk";
	
	gtk.iconTheme.package = gruvboxplus;
	gtk.iconTheme.name = "GruvboxPlus";
	home = {
		username = "hrishabh";
		homeDirectory = "/home/hrishabh";
		stateVersion = "23.11";
	};
	programs.bash = {
		enable = true;
		shellAliases = {
            wow = "amaging";
            record = "gpu-screen-recorder -w screen -f 60 -a \"default_output|default_input\" -o \"$HOME/Videos/$(date +%Y-%m-%d_%H-%M-%S).mp4\"";
			rebuild = "sudo nixos-rebuild switch";
		};
		initExtra = ''
		export __NV_PRIME_RENDER_OFFLOAD=1
		export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
		export __GLX_VENDOR_LIBRARY_NAME=nvidia
		export __VK_LAYER_NV_optimus=NVIDIA_only
		export PS1="\e[0;32m[\e[0;35m\u\e[0;32m@\[\e[0;35m\h \[\e[0;34m\W\e[0;32m]$ \e[0m" 
		'';
	};
	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};
}
