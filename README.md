# 🦁 My Neovim configuration

## ✨ Features

- It's primarily set up to work with **Go projects**.
- It’s also set up to work with **Lua projects**, as I developed this configuration in Neovim :)
- Support for other languages is partially configured. Refer to the Languages & Features table below.
- It includes the best **Git integration**, thanks to a variety of mappings and plugins.
- It includes [NvChad](https://github.com/NvChad/NvChad) modules and some features and principles from [AstroNvim](https://github.com/AstroNvim/AstroNvim).

<details><summary>🧮 Languages & Features Table</summary>

| Lang/feature   | TS         | LSP        | Format     | Lint       | Neotests     | Snippets   |
| -------------- | ---------- | ---------- | ---------- | ---------- | ------------ | ---------- |
| Go             | ✅         | ✅         | ✅         | ✅         | ✅           |            |
| JS             | ✅         |            |            |            |              |            |
| TS             | ✅         |            |            |            |              |            |
| TSX            | ✅         |            |            |            |              |            |
| Python         | ✅         |            |            |            |              |            |
| Lua            | ✅         | ✅         | ✅         | ✅ (lsp)   |              | ✅ (lsp)   |
| C++            | ✅         |            |            |            |              |            |
| Bash           | ✅         |            |            |            |              |            |
| **------**     | **------** | **------** | **------** | **------** | **------**   | **------** |
| md             | ✅         |            |            |            | ❎           |            |
| json           | ✅         |            | ✅         |            | ❎           |            |
| yaml           | ✅         |            |            |            | ❎           |            |
| toml           | ✅         |            |            |            | ❎           |            |
| docker<br>file | ✅         |            |            |            | ❎           |            |
| git<br>ignore  | ✅         |            |            |            | ❎           |            |
| make           | ✅         |            |            |            | ❎           |            |
| cmake          | ✅         |            |            |            | ❎           |            |
| html           | ✅         | ✅         |            |            | ❎           |            |
| css            | ✅         |            |            |            | ❎           |            |
| sql            | ✅         |            |            |            | ❎           |            |
| curl           | ✅         |            |            |            | ❎           |            |

</details>

## 🖍️ Principles

### 🎲 General

- **The tool should simplify and speed up my work.** This configuration is designed to make editing text and source code more convenient and efficient. If some solution looks strange but it's convenient for me, I'll use it.
- **Minimalism.** If I don't use the plugin, I delete it. If I don't use mapping, I delete it. The configuration includes only the features I need.
- **Integrity.** I have configured the plugins so that they look like a single unit. I try to use the same UI/UX principles everywhere.
- **Minimum UI - maximum UX**. I minimize the information displayed on the screen, but leave plenty of options in the keyboard shortcuts.

### 🎨 Color theme

- **Building from scratch.** I've disabled all the preset options so that they don't interfere with me setting my own color scheme.
- **Minimizing color noise**. I really like the principles of the [alabaster](https://github.com/tonsky/sublime-scheme-alabaster) theme from [@Tonsky](https://github.com/tonsky). This theme is too minimalistic and unusual for me, but these principles allowed me to take a different look at the logic of building a color theme. I use colors to highlight what is really important to me.
- **Using color to add extra meaning**. I use different colors rather than additional symbols to convey meaning.
- **Do not use italics**.

### ☄️ Mappings

- **`<leader>` is a space**.
- **Convenience and speed are more important than mnemonic rules**. In many builds such as [NvChad](https://github.com/nvchad/nvchad) or [AstroNvim](https://github.com/AstroNvim/AstroNvim) most of the mapping is based on mnemonic rules: `<leader>ff` - **F**ind **F**ile, `<leader>Ss` - **S**ave **S**ession, etc. Such mappings are easy to remember, but they're not always optimal in terms of convenience and speed of use. I don't completely abandon mnemonic rules, but I prioritize convenience over them. Because of this, not all of my mappings may be intuitive to you.
- **The more frequently a mapping is used, the shorter it should be**. Any mapping should be **no longer than 4 keystrokes**.
- **Mappings should be easy and quick to type.** I noticed that I type mapping most quickly if I press adjacent characters with different hands. The second fastest are mappings, where adjacent characters are pressed with different fingers of the same hand. And the last ones are when adjacent characters are pressed with one finger.
- **Uniformity.** For similar actions in different plugins, I use the same or similar mappings. For example, `<leader>e` - for toggle NvimTree and toggle file explorer in diffview.

## 📦 Installation

Just **clone** this repository **and run** neovim:

```shell
git clone https://github.com/Yu-Leo/nvim ~/.config/nvim && nvim
```

All plugins and extensions will be installed and configured **automatically**.

### ⚡️ Requirements

- Neovim >= 0.10.0
- a [patched font](https://www.nerdfonts.com/) for the icons, or change them to simple ASCII characters
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- git

### 🗑️ Uninstallation (Linux / MacOS)

```shell
# Remove config
rm -rf ~/.config/nvim

# Remove state
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```

## ⚙️ Structure

```shell
.
├── init.lua
├── lua
│   ├── Yu-Leo # My utilities
│   │   ├── common  # All sorts of different helper functions
│   │   ├── git  # Utilities for working with git
│   │   └── statusline  # Statusline generation framework
│   ├── autocmds.lua  # File with neovim autocmds
│   ├── chadrc.lua  # Config for NcChad modules
│   ├── configs  # Directory with plugin configurations. Imported in the `plugins/init.lua`
│   ├── mappings.lua  # File with hotkeys
│   ├── options.lua  # File with neovim options
│   ├── plugins/init.lua  # File with a list of plugins
│   ├── private  # Directory with the private part of the config. Added to .gitignore
│   ├── themes/yuth0.lua  # My color theme
│   └── usercmds.lua  # File with my custom commands
├── queries
└── spell
```

## 🚀 Development

- It's still a **Work In Progress** and is unlikely to ever be fully stable. I change and improve this configuration almost every day.
- There are **no guarantees of backward compatibility**.
- The [`develop`](https://github.com/Yu-Leo/nvim/tree/develop) branch contains the most up-to-date, but less stable version. Periodically, I squash commits in it and merge them into `main`
- Check out **my neovim plugins**:
    - [`Yu-Leo/blame-column.nvim`](https://github.com/Yu-Leo/blame-column.nvim) - displaying git blame information
    - [`Yu-Leo/gosigns.nvim`](https://github.com/Yu-Leo/gosigns.nvim) - visualizing some Go hints
    - [`Yu-Leo/cmp-go-pkgs`](https://github.com/Yu-Leo/cmp-go-pkgs) - nvim-cmp source providing the names of Go packages to import
- Check out **my other dotfiles**: [`Yu-Leo/dotfiles`](https://github.com/Yu-Leo/dotfiles)
- I’ve spent over **200 hours** learning and practicing in Vim, creating this configuration and my own plugins. I will be glad if you find something useful in them for yourself.
- License: [MIT](./LICENSE). Author: [@Yu-Leo](https://github.com/Yu-Leo)
