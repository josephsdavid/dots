with import <nixpkgs> {};
let customPlugins = {
  nvim-r = vimUtils.buildVimPlugin {
    name = "nvim-r";
    src = fetchgit {
      url= "https://github.com/jalvesaq/nvim-r";
 #     sha256 = "0ai0cr62gc7n6y22ki3qibyj1qnlaxv1miqxmmahfk3hpbyfqz9n";
 #sha256 = "0pyz20jjzbnayi2mdh2j3pg746ingdc7pvqsl2acwj93qbcmg4kq";
 sha256 = "02gr7dav4gir5d81g9r6vbjvijy2jgq64sv1by9w3mycfm3kcg35";
      #sha256 = "06wi8xsp32bkym424zxv8daxvlnkcf8q2fqc5zwhh4hmbbgy7ixj";
#      sha256 = "1d1vsl6i9dgbwj5ay4b6fkzxza7pi6f9m0v3s9936xm43mg73mbm";
    #  sha256 = "1f7ha5sjjpdsj4qpimxdnbvw38vkp0c1jvnj1jcyid10dyg14y5k";
     # rev =  "c53b5a402a26df5952718f483c7461af5bb459eb";
     # sha256 = "13xbb05gnpgmyaww6029saplzjq7cq2dxzlxylcynxhhyibz5ibv";
   };
   buildInputs = [ which vim  zip];
 };
 vim-pandoc-syntax = vimUtils.buildVimPlugin {
   name = "vim-pandoc-syntax";
   src = fetchgit {
     url = "https://github.com/vim-pandoc/vim-pandoc-syntax";
     sha256 = "1yiczv4l2rg8wva2gbjvv7k9s6y9p0gwmlazdd9rnq28nhmxx3gv";
   };
 };

 darktheme = vimUtils.buildVimPlugin {
   name = "darktheme";
   src = fetchgit {
     url = "https://github.com/sainnhe/edge";
     sha256 ="1lp5rv966nfjahgnniig12fx3zxp2qk0h2lw023fyfrhdfkvba9h";
   };
 };

 gitvim = vimUtils.buildVimPlugin {
   name = "gitvim";
   src = fetchgit {
     url = "https://github.com/cormacrelf/vim-colors-github";
     sha256 ="1nnbyl6qm7rksz4sc0cs5hgpa9sw5mlan732bnn7vn296qm9sjv1";
   };
 };

 lightline = vimUtils.buildVimPlugin {
   name = "lightline";
   src = fetchgit {
     url = "https://github.com/itchyny/lightline.vim";
     sha256 ="0yvinwvzhqb87nqg38azd19c9w0yrkl06mx3agji2mvn23p66ab5";

   };
 };

 vim-processing =  vimUtils.buildVimPlugin {
   name = "vim-processing";
   src = fetchgit {
     url = "https://github.com/sophacles/vim-processing";
     sha256 = "1irnpc08wlwwbbi48glv31s35dgn7329cqnhap66m9byqzsqyz2y";
   };
 };
};
in vim_configurable.customize {
  name = "vim";
  vimrcConfig.customRC = builtins.readFile ./vimrc;
    # Use the default plugin list shipped with nixpkgs
    vimrcConfig.vam.knownPlugins = pkgs.vimPlugins // customPlugins;
    vimrcConfig.vam.pluginDictionaries = [
      { names = [
            # Here you can place all your vim plugins
            # They are installed managed by `vam` (a vim plugin manager)
            "repeat"
            "auto-pairs"
            "Syntastic"
            "vim-nix"
            "surround"
            #"nerdtree"
            "vim-markdown"
            "vim-fugitive"
            #"vimtex"
            "vim2hs"
            "ctrlp"
            #"goyo"
            "python-mode"
      #      "nvim-r"
            "vim-slime"
            "vim-pandoc-syntax"
            "lightline"
#            "darktheme"
            #"csv"
          ]; }
        ];
      }
