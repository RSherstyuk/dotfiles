# Dotfiles Configuration

This repository contains my personal dotfiles for various tools and applications, aimed at creating a productive development environment.

## Table of Contents

- [General Setup](#general-setup)
- [Neovim (nvim)](#neovim-nvim)
  - [Installation](#nvim-installation)
  - [Plugins](#nvim-plugins)
  - [Keybindings](#nvim-keybindings)
- [Alacritty](#alacritty)
  - [Installation](#alacritty-installation)
  - [Configuration](#alacritty-configuration)
- [Tmux](#tmux)
  - [Installation](#tmux-installation)
  - [Configuration](#tmux-configuration)
- [Zsh](#zsh)
  - [Installation](#zsh-installation)
  - [Configuration](#zsh-configuration)
- [Glazewm](#glazewm)
- [Zebar](#zebar)

## General Setup

To set up these dotfiles, it's generally recommended to symlink the configuration files from this repository to their respective locations in your home directory.

```bash
# Example for a config file
ln -sfn /path/to/your/dotfiles/alacritty ~/.config/alacritty
ln -sfn /path/to/your/dotfiles/nvim ~/.config/nvim
ln -sfn /path/to/your/dotfiles/.tmux.conf ~/.tmux.conf
ln -sfn /path/to/your/dotfiles/.zshrc ~/.zshrc

# For Glazewm and Zebar, you might need to copy/symlink the entire .glzr directory
# or specific files within it, depending on how they are installed and configured.
# Assuming .glzr is in the root of the dotfiles:
ln -sfn /path/to/your/dotfiles/.glzr ~/.glzr
```

## Neovim (nvim)

My Neovim configuration uses `packer` for plugin management and is set up for various languages, especially Python and Java, with LSP support, formatters, linters, and more.

### Installation (nvim)

1.  **Install Neovim:** Ensure you have Neovim (version 0.7 or later is recommended).
    ```bash
    # Example for Ubuntu/Debian
    sudo apt install neovim
    # Or from source for latest version
    # git clone https://github.com/neovim/neovim.git
    # cd neovim && make CMAKE_BUILD_TYPE=Release
    # sudo make install
    ```
2.  **Install Packer:**
    ```bash
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    ```
3.  **Install Language Servers and other dependencies:**
    *   **Java (JDTLS):** `nvim-jdtls` is used. You'll need to set up a Java Development Kit (JDK) and ensure `jdtls` is available. The `nvim/lua/config/java.lua` file contains setup logic.
    *   **Python (Jupytext):** The configuration uses `jupytext.nvim` for working with Jupyter notebooks.
        ```bash
        pip install jupytext
        ```
    *   **Formatters (Conform):** The `nvim/lua/config/formatters.lua` uses `conform.nvim`. You will need to install the actual formatters for the languages you use (e.g., `black` for Python, `clang-format` for C/C++).
    *   **Linters (Lint.nvim):** The `nvim/lua/config/linters.lua` uses `lint.nvim`. Install linters for your languages (e.g., `flake8` for Python, `checkstyle` for Java).
4.  **Open Nvim and run `:PackerSync`** to install all plugins.

### Plugins (nvim)

Key plugins include:
-   `packer.nvim`: Plugin manager.
-   `nvim-lspconfig`, `cmp-nvim-lsp`, `cmp_luasnip`, `nvim-cmp`: LSP and autocompletion setup.
-   `nvim-jdtls`: Java Development Tools Language Server integration.
-   `L3MON4D3/LuaSnip`: Snippet engine.
-   `numToStr/Comment.nvim`: Easy commenting/uncommenting.
-   `GCBallesteros/jupytext.nvim`, `benlubas/molten-nvim`: Jupyter notebook integration.
-   `neo-tree.nvim`: File explorer.
-   `conform.nvim`: Formatter.
-   `lint.nvim`: Linter.

### Keybindings (nvim)

-   **General LSP:** `gd` (definition), `K` (hover), `<space>rn` (rename), `gi` (implementation), `<C-k>` (signature help), `<space>ca` (code action), `gr` (references), `<space>e` (diagnostics float).
-   **Commenting:** `,cc` (comment line), `,cb` (comment block).
-   **LuaSnip:** `<C-j>` (expand/jump).
-   **Language-specific run (`<C-h>`):**
    -   `lua`: `:w<CR>:!lua %<CR>`
    -   `python`: `:w<CR>:!python3 %<CR>`
    -   `c`: `:w<CR>:!gcc % -o out; ./out<CR>`
    -   `sh`, `go`: `:w<CR>:!%<CR>`
    -   `java`: `:w<CR>:!javac % && java %:r<CR>`
-   **Java (JDTLS specific):** `<leader>jo` (organize imports), `<leader>jt` (test class), `<leader>jT` (test nearest method), `<leader>je` (extract variable).

## Alacritty

Alacritty is a GPU-accelerated terminal emulator.

### Installation (Alacritty)

```bash
# Example for Ubuntu/Debian
sudo apt install alacritty
# Or follow instructions from https://github.com/alacritty/alacritty
```

### Configuration (Alacritty)

Configuration is located in `alacritty/alacritty.toml`. You can symlink this directory to `~/.config/alacritty`.
Theme files are in `alacritty/themes`.

## Tmux

Tmux is a terminal multiplexer.

### Installation (Tmux)

```bash
sudo apt install tmux
```

### Configuration (Tmux)

The configuration file is `.tmux.conf`. Symlink it to your home directory: `ln -sfn /path/to/your/dotfiles/.tmux.conf ~/.tmux.conf`.

## Zsh

Zsh is the default shell.

### Installation (Zsh)

```bash
sudo apt install zsh
chsh -s $(which zsh)
```

### Configuration (Zsh)

The configuration file is `.zshrc`. Symlink it to your home directory: `ln -sfn /path/to/your/dotfiles/.zshrc ~/.zshrc`.

## Glazewm

Glazewm is a window manager. Its configuration is in `.glzr/glazewm/config.yaml`.
You should symlink the entire `.glzr` directory to your home directory or ensure Glazewm is configured to find its configuration there.

## Zebar

Zebar is likely a status bar component associated with Glazewm. Its settings are in `.glzr/zebar/settings.json`.
As with Glazewm, ensure the `.glzr` directory is correctly symlinked or copied.
