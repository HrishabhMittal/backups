# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  #imports
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  
  #hardware
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  # hardware.cuda.enable = true;
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
    };
    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };



  #Experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];
  


  # networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  networking.hostName = "nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  




  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };






  #services
  services.upower.enable = true;
  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # awesomewm setup
    services={
        xserver = {
            enable = true;
            videoDrivers = ["nvidia"];
            windowManager.awesome = {
                enable = true;
                luaModules = with pkgs.luaPackages; [
                    luarocks # is the package manager for Lua modules
                    luadbi-mysql # Database abstraction layer
                ];

            };
        };
        displayManager = {
            sddm.enable = true;
            sddm.theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
	    defaultSession = "none+awesome";
        };
    };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;




  # user
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hrishabh = {
    isNormalUser = true;
    description = "Hrishabh mittal";
    extraGroups = [ "networkmanager" "wheel" "video"];
    packages = with pkgs; [
    #  thunderbird
    ];
  };




  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;




  #packages
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    alacritty
    home-manager
    neovim
    mpv
    discord
    obsidian
    picom
    alsa-utils
    upower
    gnumake
    killall
    yad
    zip
    unzip
    brightnessctl
    btop
    cava
    ntfs3g
    bluez
    bluez-tools
    blueman
    fastfetch
    cliphist
    pulseaudio
    sddm
    awesome
    lemonbar-xft
    rofi
    pcmanfm
    xfce.thunar
    xclip
    xsel
    wlogout
    kitty
    
    nvidia-persistenced
    
    pipewire
    pamixer
    simplescreenrecorder
    flameshot
    
    libsForQt5.qt5.qtquickcontrols2   
    libsForQt5.qt5.qtgraphicaleffects
    bibata-cursors
    gruvbox-dark-gtk
   
    nasm
    pyright
    lua-language-server
    gcc
    clang
    clang-tools
    cmake
    gnumake
    go
    gopls
    marksman
    ripgrep
    python3
    nodejs
    git
  ];



  #fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    nerdfonts
    noto-fonts-cjk-serif
  ];

  environment.variables = {
    LD_LIBRARY_PATH = "${pkgs.cudatoolkit.lib}/lib:${pkgs.linuxPackages.nvidia_x11}/lib";
    PATH = "${pkgs.cudatoolkit.bin}/bin:$PATH";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
