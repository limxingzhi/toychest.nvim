# toychest.nvim

A barely opinionated session manager for nvim.

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

### With Lazy.nvim and specifying a directory to store the sessions

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

## Usages

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

## References

- [How to write a neovim plugin](https://miguelcrespo.co/posts/how-to-write-a-neovim-plugin-in-lua/)
