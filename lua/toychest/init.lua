local default_dir = '~/.vim_sessions'

local M = {}

M.setup = function(config)
  config = config or { dir = default_dir }

  -- default session directory
  M.working_dir = vim.fn.expand(config.dir or default_dir)

  -- make the direcotry if it doesnt exist
  if M.working_dir:sub(-1) ~= "/" then
    M.working_dir = M.working_dir .. "/"
  end


  -- ensure the session directory is set up and commands are registered
  ensure_dir()
  M.setup_commands()
end

-- ensure the session directory exists
ensure_dir = function()
  -- make the direcotry if it doesnt exist
  if not vim.loop.fs_stat(M.working_dir) then
    vim.fn.mkdir(M.working_dir, "p")
  end
end

-- list all session files in the session directory
M.list_sessions = function()
  local files = vim.fn.glob(M.working_dir .. '*')
  return vim.fn.split(files, '\n')
end

-- save a session with a given name
M.save_session = function(name)
  if name and name ~= "" then
    vim.cmd(string.format('mks! %s%s', M.working_dir, name))
    print("Session saved as: " .. name)
  else
    print("Please provide a valid session name.")
  end
end

-- restore a session by name
M.restore_session = function(name)
  local session_file = M.working_dir .. name
  if vim.fn.filereadable(session_file) == 1 then
    vim.cmd(string.format('source %s', session_file))
  else
    print("Session file not found: " .. name)
  end
end

-- function for session name completion
M.complete_sessions = function(arg_lead, line, pos)
  local sessions = M.list_sessions()
  local results = {}
  for _, session in ipairs(sessions) do
    local session_name = vim.fn.fnamemodify(session, ':t')
    if session_name:find('^' .. arg_lead) then
      table.insert(results, session_name)
    end
  end
  return results
end

-- Command for saving a session
function M.setup_commands()
  vim.api.nvim_create_user_command(
    'Sesw',
    function(opts) M.save_session(opts.fargs[1]) end,
    { nargs = '*', complete = M.complete_sessions }
  )

  vim.api.nvim_create_user_command(
    'Sesr',
    function(opts)
      local sessions = M.list_sessions()
      if #opts.fargs == 0 then
        print("Available session files:")
        for _, session in ipairs(sessions) do print(" - " .. vim.fn.fnamemodify(session, ':t')) end
      else
        M.restore_session(opts.fargs[1])
      end
    end,
    { nargs = '*', complete = M.complete_sessions }
  )
end

return M
