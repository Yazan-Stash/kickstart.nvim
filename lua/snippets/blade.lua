local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Livewire Tag (lw)
  s('lw', {
    t('<livewire:'),
    i(1),
    t(' />'),
  }),
}
