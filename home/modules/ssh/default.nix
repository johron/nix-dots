{ config, lib, ... }:
{
  sops.secrets = {
    "ssh/github-johron" = {
      path = "${config.home.homeDirectory}/.ssh/keys/github-johron";
      mode = "0600";
    };
    "ssh/codeberg-johron" = {
      path = "${config.home.homeDirectory}/.ssh/keys/codeberg-johron";
      mode = "0600";
    };
    "ssh/ntnu-github-johanhr" = {
      path = "${config.home.homeDirectory}/.ssh/keys/ntnu-github-johanhr";
      mode = "0600";
    };
    "ssh/forgejo-johron" = {
      path = "${config.home.homeDirectory}/.ssh/keys/forgejo-johron";
      mode = "0600";
    };

    "ssh/moholt-janitor" = {
      path = "${config.home.homeDirectory}/.ssh/keys/moholt-janitor";
      mode = "0600";
    };
  };

  programs.ssh = {
    enable = true;

    extraConfig = ''
      IdentitiesOnly yes
    '';

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "johron";
        identityFile = config.sops.secrets."ssh/github-johron".path;
        identitiesOnly = true;
      };

      "codeberg.org" = {
        hostname = "codeberg.org";
        user = "git";
        identityFile = config.sops.secrets."ssh/codeberg-johron".path;
        identitiesOnly = true;
      };

      "git.ntnu.no" = {
        hostname = "git.ntnu.no";
        user = "git";
        identityFile = config.sops.secrets."ssh/ntnu-github-johanhr".path;
        identitiesOnly = true;
      };

      "git.johron.no" = {
        hostname = "git.johron.no";
        user = "git";
        port = 2244;
        identityFile = config.sops.secrets."ssh/forgejo-johron".path;
        identitiesOnly = true;
      };

      "moholt" = {
        hostname = "192.168.0.150";
        user = "janitor";
        port = 22;
        identityFile = config.sops.secrets."ssh/moholt-janitor".path;
        identitiesOnly = true;
      };

      "moholt-pub" = {
        hostname = "109.108.211.77";
        user = "janitor";
        port = 5959;
        identityFile = config.sops.secrets."ssh/moholt-janitor".path;
        identitiesOnly = true;
      };

      "109.108.211.77" = {
        hostname = "109.108.211.77";
        user = "janitor";
        port = 5959;
        identityFile = config.sops.secrets."ssh/moholt-janitor".path;
        identitiesOnly = true;
      };
    };
  };

  home.activation.ensureSshDirectories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/.ssh/keys"
    chmod 700 "${config.home.homeDirectory}/.ssh"
    chmod 700 "${config.home.homeDirectory}/.ssh/keys"
  '';

  home.file = {
    ".ssh/keys/github-johron.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN+qZbeUx9eFm/ZAeABAJP276dN1yRw4uLZIkSB4sNfa johanhrong@icloud.com
    '';
    ".ssh/keys/codeberg-johron.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICtrY2ArMsPo0PUj35EbnF4S28kOfYr5+3MRtDULFeCJ johron@straume
    '';
    ".ssh/keys/ntnu-github-johanhr.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPebyNcvVBwSauBHyLlrC43jBIfrdzzxGkmj5p1h1NAb johanhr@stud.ntnu.no
    '';
    ".ssh/keys/forgejo-johron.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICC3ti/G1y+Zh2uVKkSEJrYgxsQWyLUSZDEyf71bG8ps johanhrong@icloud.com
    '';
    ".ssh/keys/moholt-janitor.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIAeqt18TNlmeqMAPP+Pkb5EGpU9D1RBcyV71/NNI3HQ johron@ideapad
    '';
  };
}