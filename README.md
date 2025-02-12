## description
Welcome to my overengineered configuration for my computer systems. A concoction of my better hallucinations, not very carefully orchestrated to (hopefully) do something that is at least partially useful. I've made this public for it to be used as a reference (and so that i can install it faster on random systems)


This config is not a finished product, and will change as a continue to learn about nix. Things will be modified, updated, added, removed and restructured without warning. I commit each time I (successfully) rebuild so a large amount of commits are incomplete and or broken. So if you take something make sure that you understand what it does. It is also made specifically for my machine with their own quirks. Don't expect it to work on yours. If you decide to (against my advice) try to boot this. Please make sure you have backups of your data. And a good backup plan in the case that you can't boot. 

![my desktop](https://github.com/Eradax/NixOs/blob/main/misc/images/desktop.png?raw=true)


## features
- home-manager, used to configure users 
- impermanence, (almost) everything is wiped in reboot, only /persist persists
- modular, each thing is it's own module that you can enable
  - nixos modules are in modules/nixos
  - home-manager modules are in modules/home
- disko, for declarative disks
- file hierarchy based hosts and users
  - logic in hosts/default.nix
  - machines defined in hosts/${host name}
  - users defined in hosts/\${host name}/users/\${user name}
- custom top bar made with ags

The structure of my config was inspired by [NotAShelf](https://notashelf.dev/) and [Jake Hamilton](https://jakehamilton.dev/)

## install
```bash 
# Warning this will format your system with disko 
nix --extra-experimental-features "flakes " run github:eradax/nixos#install 
```


## create iso
to create the ISOs you have to run the following commands
    
    `
    
    `{:.bash}


## inspiration
Some of the people that I've ~stolen from~ been inspired by. There's probably a lot more but I tend to forget to add them. 

- [Jake Hamilton](https://github.com/jakehamilton/config) - config organised into modules and suites 
- [Loke Gustafsson](https://github.com/lokegustafsson/nixos-getting-started) - nix defaults, especially the global pining of nixpkgs
- [ErrorNoInternet](https://github.com/ErrorNoInternet/configuration.nix) - nixvim config used as a reference
- [vimjoyer](https://www.youtube.com/@vimjoyer) - easy to follow guides for everything nix
- [NoBoilerplate](https://www.youtube.com/@NoBoilerplate) - made me start my Stockholm syndrome filled journey with nixos
- [NobbZ](https://github.com/NobbZ/nixos-config/) - nix sops
- [SebastianStork](https://github.com/SebastianStork/nixos-config) - nix sops
- [fufexan](https://github.com/fufexan/dotfiles)
- [mic92](https://github.com/Mic92/dotfiles)
- [Workflow](https://github.com/workflow/dotfiles)
- [Notohh](https://github.com/notohh/snowflake)
- [Adamcstephens](https://codeberg.org/adamcstephens/dotfiles)
- [Goxore](https://github.com/Goxore/nixconf)
- [LibrePhoenix](https://github.com/librephoenix/nixos-config)

