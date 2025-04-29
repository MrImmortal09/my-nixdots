# any file in `./modules/hm/`
{
  home.file = {
    # copy kitty config to your template flake
    # cp ~/.config/kitty/kitty.conf ~/path/to/flake/kitty.conf
    ".config/hypr/monitors.conf" = {
      source = ../../hypr/monitors.conf; # path to your kitty config in your template flake
    };
    
  };
}
