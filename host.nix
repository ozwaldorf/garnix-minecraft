{ pkgs, ... }:
let
  sshKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCatP3klEjfQPSiJNUc3FRDdz927BG1IzektpouzOZR" ];
  host = "server.main.garnix-minecraft.p1n3appl3.garnix.me";
in
{
  garnix.server = { enable = true;
    persistence = { enable = true;
      name = "minecraft";
    };
  };
  services.openssh.enable = true;

  users.users.julia = {
    isNormalUser = true;
    description = "julia";
    extraGroups = [ "wheel" "systemd-journal" ];
    openssh.authorizedKeys.keys = sshKeys;
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = [
    pkgs.htop
  ];

  services.minecraft-server = { enable = true;
    eula = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 25565 ];
  networking.firewall.allowedUDPPorts = [ 25565 ];
  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };
   system.stateVersion = "24.05";
}

