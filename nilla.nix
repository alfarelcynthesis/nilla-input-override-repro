(import (import ./npins).nilla).create (
  { config, lib }:
  {
    # import all inputs from npins: nilla, nilla-cli, and nixpkgs
    config.inputs = builtins.mapAttrs (_name: pin: { src = pin; }) (import ./npins);

    # set an extend module that should override nilla-cli's nixpkgs version
    includes = [
      {
        config.inputs.nilla-cli.settings.extend.modules = [
          {
            config.inputs.nixpkgs.src = lib.modules.overrides.force config.inputs.nixpkgs.src;
          }
        ];
      }
    ];
  }
)
