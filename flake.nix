{
  description = "Nix package for codex-acp";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    version = "2.1.1";
    srcHash = "sha256-bSxt9vtFnIrdZDmFJdYAfqkgm4BrGYKe420RamPkZvg=";
    npmDepsHash = "sha256-7v7QE0cmYsd3JGu0VoT53yZ1rb9wYB+tXt05G1EEvz8=";
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
    mkPackage = pkgs:
      pkgs.buildNpmPackage {
        pname = "codex-acp";
        inherit version npmDepsHash;

        src = pkgs.fetchFromGitHub {
          owner = "agentclientprotocol";
          repo = "codex-acp";
          rev = "v${version}";
          hash = srcHash;
        };

        meta = {
          description = "Agent Client Protocol adapter for Codex CLI";
          homepage = "https://github.com/agentclientprotocol/codex-acp";
          license = pkgs.lib.licenses.asl20;
          mainProgram = "codex-acp";
          platforms = supportedSystems;
        };
      };
  in {
    overlays.default = final: _prev: {
      codex-acp = mkPackage final;
    };

    packages = nixpkgs.lib.genAttrs supportedSystems (system: {
      default = self.packages.${system}.codex-acp;
      codex-acp = mkPackage nixpkgs.legacyPackages.${system};
    });
  };
}
