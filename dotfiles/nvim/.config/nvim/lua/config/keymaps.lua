-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keymaps personalizados (dot-catppuccin / BR / QWERTY-ABNT2)
local map = vim.keymap.set

-- Cheatsheet
map("n", "<F1>", "<cmd>edit ~/.config/nvim/lua/config/keymaps.lua<CR>", {
  desc = "Abrir cheatsheet de atalhos",
})

-- Save / quit / copy
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Salvar arquivo" })
map("n", "<C-q>", "<cmd>wqa<CR>", { desc = "Salvar e sair de tudo" })
map("n", "<F2>", "<cmd>qa!<CR>", { desc = "Sair sem salvar" })
map("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Salvar arquivo" })
map("i", "<C-q>", "<Esc><cmd>wqa<CR>a", { desc = "Salvar e sair de tudo" })
map("n", "<leader>qq", "<cmd>wqa<CR>", { desc = "Salvar e sair de tudo" })
map("n", "<leader>qQ", "<cmd>qa!<CR>", { desc = "Sair sem salvar" })
map("n", "<A-c>", "<cmd> %y+ <CR>", { desc = "Copiar conteúdo todo" })
map("n", "<C-d>", ":%d<CR>", { noremap = true, silent = true, desc = "Deleta todo conteudo" })

-- Buffers (Snacks/LazyVim — explorer em vez de NvimTree)
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Próximo buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Buffer anterior" })

map("n", "<A-q>", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_ft = vim.bo[current_buf].filetype

  -- Snacks explorer / picker / layout — não fechar como buffer normal
  if current_ft:match("^snacks") or current_ft == "NvimTree" then
    vim.cmd("wincmd p")
    return
  end

  vim.cmd("BufferLineCycleNext")
  vim.cmd("bdelete " .. current_buf)
end, { desc = "Fechar buffer atual" })

-- Links e arquivos nativos do Vim
map("n", "gx", "gx", { desc = "Abrir link no navegador" })
map("n", "gf", "gf", { desc = "Abrir arquivo sob cursor" })

-- Copy PATH
vim.keymap.set("n", "<leader>cp", function()
  local full = vim.fn.expand("%:p")
  vim.fn.setreg("+", full)
  print("Caminho completo copiado: " .. full)
end, { desc = "Copiar caminho completo do arquivo" })

vim.keymap.set("n", "<leader>cr", function()
  local rel = vim.fn.expand("%")
  vim.fn.setreg("+", rel)
  print("Caminho relativo copiado: " .. rel)
end, { desc = "Copiar caminho relativo" })

vim.keymap.set("n", "<leader>cd", function()
  local dir = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", dir)
  print("Diretório copiado: " .. dir)
end, { desc = "Copiar diretório do arquivo" })

vim.keymap.set("n", "<leader>cf", function()
  local name = vim.fn.expand("%:t")
  vim.fn.setreg("+", name)
  print("Nome do arquivo copiado: " .. name)
end, { desc = "Copiar nome do arquivo" })

-- Abrir explorer (Snacks) ao iniciar nvim sem argumentos
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  once = true,
  callback = function()
    if vim.fn.argc() == 0 and vim.g.snacks then
      vim.schedule(function()
        require("snacks").explorer.open()
      end)
    end
  end,
})
