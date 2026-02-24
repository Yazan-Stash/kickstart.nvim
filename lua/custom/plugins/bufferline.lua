return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  opts = {
    options = {
      numbers = 'ordinal',
      diagnostics = 'nvim_lsp',
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = 'thin',
    },
  },
  keys = {
    { '<leader>1', '<cmd>BufferLineGoToBuffer 1<CR>', desc = 'Go to buffer 1' },
    { '<leader>2', '<cmd>BufferLineGoToBuffer 2<CR>', desc = 'Go to buffer 2' },
    { '<leader>3', '<cmd>BufferLineGoToBuffer 3<CR>', desc = 'Go to buffer 3' },
    { '<leader>4', '<cmd>BufferLineGoToBuffer 4<CR>', desc = 'Go to buffer 4' },
    { '<leader>5', '<cmd>BufferLineGoToBuffer 5<CR>', desc = 'Go to buffer 5' },
    { '<leader>6', '<cmd>BufferLineGoToBuffer 6<CR>', desc = 'Go to buffer 6' },
    { '<leader>7', '<cmd>BufferLineGoToBuffer 7<CR>', desc = 'Go to buffer 7' },
    { '<leader>8', '<cmd>BufferLineGoToBuffer 8<CR>', desc = 'Go to buffer 8' },
    { '<leader>9', '<cmd>BufferLineGoToBuffer 9<CR>', desc = 'Go to buffer 9' },
    { '<leader>w', '<cmd>bdelete<CR>', desc = 'Close current buffer' },
    { '<leader>W', '<cmd>bufdo bdelete<CR>', desc = 'Close all buffers' },
  },
}
