# codex-acp-nix

Nix flake tracking the latest [codex-acp](https://github.com/agentclientprotocol/codex-acp).

```nix
{
  inputs.codex-acp-nix.url = "git+ssh://git@forgejo.example/nelyah/codex-acp-nix";

  outputs = {nixpkgs, codex-acp-nix, ...}: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      modules = [({pkgs, ...}: {
        nixpkgs.overlays = [codex-acp-nix.overlays.default];
        environment.systemPackages = [pkgs.codex-acp];
      })];
    };
  };
}
```

The hourly Forgejo workflow uses a `nix` runner with Git, Node.js, OpenSSH, and a write-capable SSH key. Set `FORGEJO_SSH_REMOTE` to the repository SSH URL.
