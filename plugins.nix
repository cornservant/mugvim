{
  bigfile = {
    type = "github";
    owner = "LunarVim";
    repo = "bigfile.nvim";
    rev = "33eb067e3d7029ac77e081cfe7c45361887a311a";
    hash = "sha256-fabA2mVZAZg5Qot4ED9cJ1YMZ4wX4OvURNhIvKltFtA=";
  };
  editorconfig = {
    type = "github";
    owner = "editorconfig";
    repo = "editorconfig-vim";
    rev = "c0227885a06b155d5aa5465e08b9800e8c939f70";
    hash = "sha256-IBxOxw9Rg5P6Oa/jIcgxKYgB9pZQe9hpy3PEyzWU2IE=";
  };
  "blink.cmp" = {
    type = "github";
    owner = "saghen";
    repo = "blink.cmp";
    rev = "v1.10.2";
    hash = "sha256-C1FpyGw0f35NdHvDUGPXxmKdOgw3SpIteK1gAjVy6Ns=";
    depends = [ "luasnip" ];
  };
  bufferline = {
    type = "github";
    owner = "akinsho";
    repo = "bufferline.nvim";
    rev = "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3";
    hash = "sha256-ae4MB6+6v3awvfSUWlau9ASJ147ZpwuX1fvJdfMwo1Q=";
  };
  bufferline-editor = {
    type = "git";
    url = "https://git.loporrit.de/long/bufferline-editor.nvim";
    rev = "84aae6b5123ea09a3f7b9c720fdab34828a7a590";
    hash = "sha256-rrurGpDyoHBgKKJxUOxzPnmDpRqYFMCXKsoIk1UsrHg=";
    depends = [
      "bufferline"
      "nvim-webdev-icons"
    ];
  };
  cloak = {
    type = "github";
    owner = "laytan";
    repo = "cloak.nvim";
    rev = "648aca6d33ec011dc3166e7af3b38820d01a71e4";
    hash = "sha256-V7oNIu7IBAHqSrgCNoePNUPjQDU9cFThFf7XGIth0sk=";
  };
  Comment = {
    type = "github";
    owner = "numToStr";
    repo = "Comment.nvim";
    rev = "e30b7f2008e52442154b66f7c519bfd2f1e32acb";
    hash = "sha256-h0kPue5Eqd5aeu4VoLH45pF0DmWWo1d8SnLICSQ63zc=";
  };
  gitsigns = {
    type = "github";
    owner = "lewis6991";
    repo = "gitsigns.nvim";
    rev = "6d808f99bd63303646794406e270bd553ad7792e";
    hash = "sha256-+pXpWJkI2OMheakH5NNtUpKJbq4LN2ejCEN9/Qaxh4Y=";
  };
  kanagawa = {
    type = "github";
    owner = "rebelot";
    repo = "kanagawa.nvim";
    rev = "8ad3b4cdcc804b332c32db8f9743667e1bb82b99";
    hash = "sha256-vAq9ZiG3s4x/xFSKt9/o40pptj2y7S8DQqs1dJEdhVU=";
  };
  lsp_lines = {
    type = "git";
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim";
    rev = "a92c755f182b89ea91bd8a6a2227208026f27b4d";
    hash = "sha256-jHiIZemneQACTDYZXBJqX2/PRTBoxq403ILvt1Ej1ZM=";
  };
  lspconfig = {
    type = "github";
    owner = "neovim";
    repo = "nvim-lspconfig";
    rev = "e146efacbafed3789ac568abcc5a981c5decaa58";
    hash = "sha256-Nm4eBblqKWGUSbScIdOpsWnzTW4md2bgADl8lF0IUxc=";
  };
  lualine = {
    type = "github";
    owner = "nvim-lualine";
    repo = "lualine.nvim";
    rev = "a905eeebc4e63fdc48b5135d3bf8aea5618fb21c";
    hash = "sha256-PHunrG0yd3pDw3c1S9w1AXQx5/1nT68M+mjxT53enmM=";
    depends = [ "nvim-webdev-icons" ];
  };
  luasnip = {
    type = "github";
    owner = "L3MON4D3";
    repo = "LuaSnip";
    rev = "v2.5.0";
    hash = "sha256-diZO1on0rlSp6XuNGN2lNa85rhkNe1QQOejJD+LKkZk=";
  };
  multicursor = {
    type = "github";
    owner = "jake-stewart";
    repo = "multicursor.nvim";
    rev = "1.0";
    hash = "sha256-JHl8Z7ESrWus2I6Pe+6gmdgCAZOzAKX7kimy71sAoe4=";
  };
  neogit = {
    type = "github";
    owner = "NeogitOrg";
    repo = "neogit";
    rev = "d1cfc4986195239cac55700b675cea7a9578d430";
    hash = "sha256-iEFIfr8Fd4qwxF+z16Zj/QZBV3VQJl/mkjCRsypzQvQ=";
    depends = [ "plenary" ];
  };
  nvim-cmp = {
    type = "github";
    owner = "hrsh7th";
    repo = "nvim-cmp";
    rev = "a1d504892f2bc56c2e79b65c6faded2fd21f3eca";
    hash = "sha256-uzfM8DLRKshESsYmUAbSfXtos9COWpe/fVkxNJPIUFw=";
  };
  nvim-treesitter = {
    type = "github";
    owner = "nvim-treesitter";
    repo = "nvim-treesitter";
    rev = "4916d6592ede8c07973490d9322f187e07dfefac";
    hash = "sha256-PQR6tFt4lCrAZNQG7BLMD1IiCKja9wDS1S4laGJf/HE=";
  };
  nvim-treesitter-context = {
    type = "github";
    owner = "nvim-treesitter";
    repo = "nvim-treesitter-context";
    rev = "b0c45cefe2c8f7b55fc46f34e563bc428ef99636";
    hash = "sha256-K4o+iJY8+D0PRvRvXuBqX2q3fwxizAPp/FFpm0O0I9E=";
  };
  nvim-webdev-icons = {
    type = "github";
    owner = "nvim-tree";
    repo = "nvim-web-devicons";
    rev = "c72328a5494b4502947a022fe69c0c47e53b6aa6";
    hash = "sha256-onh54VN8/i9Btwt/aF09jJTBOS/N0Thi0QjjA02SN6o=";
  };
  obsidian = {
    type = "github";
    # owner = "epwalsh";
    owner = "cornservant";
    repo = "obsidian.nvim";
    rev = "c2be5d6721e362bf9fe2d8d191f5d136217d05e5";
    hash = "sha256-ufiaWohBpiC8G86XxNrH8SzxoZV0Q8tn0swrbUt2SR0=";
    depends = [
      "plenary"
      "nvim-cmp"
      "snacks"
    ];
  };
  oil = {
    type = "github";
    owner = "stevearc";
    repo = "oil.nvim";
    rev = "0fcc83805ad11cf714a949c98c605ed717e0b83e";
    hash = "sha256-hoTQoNEsCbZ0aZMUUUvgkC9NYjovjUUirw2FN9b9dn0=";
  };
  plenary = {
    type = "github";
    owner = "nvim-lua";
    repo = "plenary.nvim";
    rev = "74b06c6c75e4eeb3108ec01852001636d85a932b";
    hash = "sha256-nkfETDkPiE+Kd2BWYZijgUp9bP8RgFwRmvqJz2BMuq4=";
  };
  rose-pine = {
    type = "github";
    owner = "rose-pine";
    repo = "neovim";
    rev = "9504524e5ed0e326534698f637f9d038ba4cd0ee";
    hash = "sha256-e481yg0oMqY4PTEZwK1CbcJIsXN6YfBixFhx2Ab0mFg=";
  };
  vim-surround = {
    type = "github";
    owner = "tpope";
    repo = "vim-surround";
    rev = "3d188ed2113431cf8dac77be61b842acb64433d9";
    hash = "sha256-DZE5tkmnT+lAvx/RQHaDEgEJXRKsy56KJY919xiH1lE=";
  };
  vim-repeat = {
    type = "github";
    owner = "tpope";
    repo = "vim-repeat";
    rev = "65846025c15494983dafe5e3b46c8f88ab2e9635";
    hash = "sha256-G/dmkq1KtSHIl+I5p3LfO6mGPS3eyLRbEEsuLbTpGlk=";
  };
  vim-just = {
    type = "github";
    owner = "NoahTheDuke";
    repo = "vim-just";
    rev = "11b0f3177e2854cafa0c4baef5329e7d0f0dccbd";
    hash = "sha256-nCW8+x64GiJkbKshi3RhfRQoceTV5QPXs0mculC8xhM=";
  };
  vim-peekaboo = {
    type = "github";
    owner = "junegunn";
    repo = "vim-peekaboo";
    rev = "2a8a3187ba6b15201b2563a3f0331fcdf49da36c";
    hash = "sha256-faJqZI4oWqNTwbN6nX4nUR0hKiSx0nOcG8eDlzPH17E=";
  };
  # outline = {
  #   type = "github";
  #   owner = "hedyhli";
  #   repo = "outline.nvim";
  #   rev = "c293eb56db880a0539bf9d85b4a27816960b863e";
  #   hash = "sha256-xKu05IgOpgtt2W+WqXuTUjX66ffDrU8BDi8z7M6M1q4=";
  # };
  snacks = {
    type = "github";
    owner = "folke";
    repo = "snacks.nvim";
    rev = "ad9ede6a9cddf16cedbd31b8932d6dcdee9b716e";
    hash = "sha256-7lDH1JlTM+H/LWjMlAQPNY6A+xmS/cp+wChy4buGYIU=";
  };
  todo-comments = {
    type = "github";
    owner = "folke";
    repo = "todo-comments.nvim";
    rev = "31e3c38ce9b29781e4422fc0322eb0a21f4e8668";
    hash = "sha256-VGeIRfwQsHgSO89Pmn6yIP9na1F6mmYZx0HDLe9IKCQ=";
  };
  trouble = {
    type = "github";
    owner = "folke";
    repo = "trouble.nvim";
    rev = "bd67efe408d4816e25e8491cc5ad4088e708a69a";
    hash = "sha256-6U/KWjvRMxWIxcsI2xNU/ltfgkaFG4E3BdzC7brK/DI=";
    depends = [ "nvim-webdev-icons" ];
  };
  tokyonight = {
    type = "github";
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6";
    hash = "sha256-a9iRWue7DB7s/wNdxqqB51Jya5P9X6sDftqhdmKggU0=";
  };
  undotree = {
    type = "github";
    owner = "mbbill";
    repo = "undotree";
    rev = "6fa6b57cda8459e1e4b2ca34df702f55242f4e4d";
    hash = "sha256-0fSCkozz9UWkkV1PsCCnIimOHsmXw9jLd9/oF9dLjMk=";
  };
  vim-table-mode = {
    type = "github";
    owner = "dhruvasagar";
    repo = "vim-table-mode";
    rev = "bb025308a45c67c7c8f0763ba37bc2ee3f534df0";
    hash = "sha256-oHK0dJKBd4i412JhMrHW51U3/rL6Qy4CFXT9RNFGeFY=";
  };
  which-key = {
    type = "github";
    owner = "folke";
    repo = "which-key.nvim";
    rev = "3aab2147e74890957785941f0c1ad87d0a44c15a";
    hash = "sha256-rKaYnXM4gRkkF/+xIFm2oCZwtAU6CeTdRWU93N+Jmbc=";
  };
}
