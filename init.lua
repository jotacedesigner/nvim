-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
--Deshabilitar diagnostico a entrar en modo de inssercion
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "n:i", "v:s" },
  desc = "Deshabilitar Diagnosticos",
  callback = function(e)
    vim.diagnostic.disable(e.buf)
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "i:n",
  desc = "Habilitar Diagnosticos",
  callback = function(e)
    vim.diagnostic.enable(e.buf)
  end,
})
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
