{ pkgs, ... }:
let
  sshKeys = [
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBOa6Afp4TFx1do9jqGmZVRVrVJpu5qsIehS///ZY4iYCn5wkJdCNVxwx49XWV50rfB561MsX2mQHg4/8JQA+18w="
  ];
in
{
  garnix.server = {
    enable = true;
    persistence = {
      enable = true;
      name = "minecraft";
    };
  };
  services.openssh.enable = true;

  users.users.oz = {
    isNormalUser = true;
    description = "oz";
    extraGroups = [
      "wheel"
      "systemd-journal"
    ];
    openssh.authorizedKeys.keys = sshKeys;
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = [ pkgs.bottom ];

  services.minecraft-server = {
    enable = true;
    eula = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
    25565
  ];
  networking.firewall.allowedUDPPorts = [ 25565 ];
  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };
  system.stateVersion = "24.05";
}
