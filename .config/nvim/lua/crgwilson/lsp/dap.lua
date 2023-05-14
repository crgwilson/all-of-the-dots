local dap_ok, dap = pcall(require, "dap")
local dap_ui_ok, dap_ui = pcall(require, "dapui")
local dap_virtual_text_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")

if not dap_ok or not dap_ui_ok or not dap_virtual_text_ok then
  vim.notify("Could not load dap, debuggers will be broken", 2)
  return
end

-- Need nerdfont v3.0 compatible font for the detaults
dap_ui.setup({
  controls = {
    icons = {
      disconnect = "D",
      pause = "P",
      play = "PL",
      run_last = "RL",
      step_back = "SB",
      step_into = "SI",
      step_out = "SO",
      step_over = "SV",
      terminate = "T",
    }
  },
  icons = {
    collapsed = ">",
    expanded = "v",
    current_frame = "->"
  }
})
dap_virtual_text.setup({
  commented = true,
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dap_ui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dap_ui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dap_ui.close()
end
