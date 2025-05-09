{
  description = "Tripercy system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
      configuration = { pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;

        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            pkgs.neovim
            pkgs.tmux
            pkgs.corepack_latest
            pkgs.zoxide
            pkgs.vscode
            pkgs.iterm2
            pkgs.lazygit
            pkgs.bat
            pkgs.zig
            pkgs.dotnet-sdk_8
            pkgs.ripgrep
            pkgs.clang-tools
            pkgs.lldb
            pkgs.docker
            pkgs.go
            pkgs.ffmpeg
            pkgs.fd
            pkgs.neofetch
            pkgs.just
            pkgs.eza
          ];

        programs.zsh.promptInit = ''
          source ${pkgs.spaceship-prompt}/share/zsh/themes/spaceship.zsh-theme
        '';
        homebrew =
          {
            enable = true;
            onActivation = {
              autoUpdate = true;
              cleanup = "uninstall";
              upgrade = true;
            };
            taps = [
              "mongodb/brew"
            ];

            brews = [
              "mas"
              "fzf"
              "rbenv"
              "node"
              "llvm"
              "libomp"
              "gcc"
              "python@3.10"
              "python@3.11"
              "python@3.12"
              "mpich"
              {
                name = "mongodb-community@7.0";
                restart_service = true;
                link = true;
              }
            ];

            casks = [
              "notion"
              "the-unarchiver"
              "android-platform-tools"
              "swimat"
            ];

            masApps = {
              # Xcode = 497799835;
            };
          };

        fonts.packages =
          [
            pkgs.nerd-fonts.monoid
          ];

        system.defaults = {
          dock.autohide = true;
          dock.tilesize = 48;
          dock.orientation = "left";
          dock.persistent-others = [ ];
          dock.show-recents = false;
          dock.wvous-bl-corner = 1;
          dock.wvous-br-corner = 1;
          dock.wvous-tl-corner = 1;
          dock.wvous-tr-corner = 1;

          dock.persistent-apps = [
            "/System/Applications/Mail.app"
            "/Applications/Google Chrome.app"
            "/Applications/Notion.app"
            "${pkgs.vscode}/Applications/Visual Studio Code.app"
            "${pkgs.iterm2}/Applications/iTerm2.app"
          ];

          finder.FXPreferredViewStyle = "clmv";
          finder.QuitMenuItem = true;
        };

        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."m1air" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # apple silicon
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "tripercy";

              autoMigrate = true;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."m1air".pkgs;
    };
}
