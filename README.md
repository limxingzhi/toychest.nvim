# ToyChest.nvim

A barely opinionated session manager for nvim, ToyChest.nvim.

## Installation

By default, the sessions will be stored and read at `~/.vim_sessions`. That could be configured via the `setup` function.

### With Lazy.nvim

```lua
{
  "limxingzhi/toychest.nvim",
  config = function()
    require("toychest").setup()
  end
},
```

## Usages

### Usage with commands

The underlying implementation uses `:mks!` and `:source`.

List available sessions:
```vim
:Sesr
```

Write/save the current session:
```vim
:Sesw <session_name>
```

Read/replay a session:
```vim
:Sesr <session_name>
```

### Custom directory for sessions

You can set a custom directory.

```lua
{
  "limxingzhi/toychest.nvim",
  config = function()
    require("toychest").setup({
      dir = '~/.my_sessions' -- directory for your sessions
    })
  end
},
```

### Usage with bindings

You can also call the `save_sessions(name)` and `restore_session(name)` functions directly to read and write sessions.

This example assigns keybinds to read and write sessions based on the branch name.

```lua
{
  "limxingzhi/toychest.nvim",
  config = function()
    require("toychest").setup()

    -- "vim session write" : save current session based on branch name
    vim.keymap.set({ "n" }, "<leader>vsw", function()
      local branch = vim.fn.system "git branch --show-current | tr -d '\n'"
      require('toychest').save_session(branch)
    end)

    -- "vim session read" : restore current session based on branch name
    vim.keymap.set({ "n" }, "<leader>vsr", function()
      local branch = vim.fn.system "git branch --show-current | tr -d '\n'"
      require('toychest').restore_session(branch)
    end)
  end
},
```

## References

- [How to write a neovim plugin](https://miguelcrespo.co/posts/how-to-write-a-neovim-plugin-in-lua/)
