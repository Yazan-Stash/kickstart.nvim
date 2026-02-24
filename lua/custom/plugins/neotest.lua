return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- PHP/PHPUnit adapter
      'olimorris/neotest-phpunit',
    },
    config = function()
      local neotest = require 'neotest'

      neotest.setup {
        adapters = {
          require 'neotest-phpunit' {
            -- PHPUnit command configuration
            -- phpunit_cmd = function()
            --   return "vendor/bin/phpunit" -- default
            -- end,
            -- root_files = { "composer.json", "phpunit.xml", ".git" },
          },
        },
        -- Optional: Configure output window
        output = {
          enabled = true,
          open_on_run = true,
        },
        -- Optional: Configure quickfix
        quickfix = {
          enabled = true,
          open = false,
        },
        -- Optional: Configure status signs
        status = {
          enabled = true,
          signs = true,
          virtual_text = false,
        },
        -- Optional: Configure icons
        icons = {
          running = '⟳',
          passed = '✓',
          failed = '✗',
          skipped = '⊘',
          unknown = '?',
        },
      }

      -- Helper function to switch between test and implementation files
      local function switch_test_file()
        local file = vim.fn.expand '%:p'
        local alternate_file = nil

        -- Check if current file is a test
        if file:match '/tests/' or file:match 'Test%.php$' then
          -- Switch to implementation
          -- Transform: tests/Feature/ExampleTest.php -> app/Example.php
          -- Or: tests/Unit/Services/UserServiceTest.php -> app/Services/UserService.php
          alternate_file = file:gsub('/tests/Feature/', '/app/'):gsub('/tests/Unit/', '/app/'):gsub('Test%.php$', '.php')
        else
          -- Switch to test
          -- Try to determine if it should be Feature or Unit test
          -- Default to Feature test
          local test_type = 'Feature'

          -- Transform: app/Services/UserService.php -> tests/Unit/Services/UserServiceTest.php
          -- or: app/Http/Controllers/UserController.php -> tests/Feature/Http/Controllers/UserControllerTest.php
          if file:match '/app/' then
            -- For services, models, etc., use Unit tests
            if file:match '/Services/' or file:match '/Models/' then
              test_type = 'Unit'
            end

            alternate_file = file:gsub('/app/', '/tests/' .. test_type .. '/'):gsub('%.php$', 'Test.php')
          end
        end

        if alternate_file and vim.fn.filereadable(alternate_file) == 1 then
          vim.cmd('edit ' .. alternate_file)
        else
          print('Alternate file not found: ' .. (alternate_file or 'unknown'))
        end
      end

      -- Key mappings using leader key (matching Sublime Text PHPUnit workflow)
      -- <leader>ta: Run all tests in current file (phpunit_test_file)
      vim.keymap.set('n', '<leader>ta', function()
        neotest.run.run(vim.fn.expand '%')
      end, { desc = '[T]est [A]ll in file' })

      -- <leader>tn: Run nearest test under cursor (phpunit_test_nearest)
      vim.keymap.set('n', '<leader>tn', function()
        neotest.run.run()
      end, { desc = '[T]est [N]earest' })

      -- <leader>tl: Re-run last test (phpunit_test_last)
      vim.keymap.set('n', '<leader>tl', function()
        neotest.run.run_last()
      end, { desc = '[T]est [L]ast' })

      -- <leader>ts: Switch between test and implementation file (phpunit_test_switch)
      vim.keymap.set('n', '<leader>ts', switch_test_file, { desc = '[T]est [S]witch file' })

      -- Additional test management commands
      vim.keymap.set('n', '<leader>tS', function()
        neotest.summary.toggle()
      end, { desc = '[T]est [S]ummary panel' })

      vim.keymap.set('n', '<leader>to', function()
        neotest.output.open { enter = true }
      end, { desc = '[T]est [O]utput window' })

      vim.keymap.set('n', '<leader>tO', function()
        neotest.output_panel.toggle()
      end, { desc = '[T]est [O]utput panel' })

      vim.keymap.set('n', '<leader>tx', function()
        neotest.run.stop()
      end, { desc = '[T]est sto[X]' })

      vim.keymap.set('n', '<leader>tw', function()
        neotest.watch.toggle()
      end, { desc = '[T]est [W]atch mode' })

      vim.keymap.set('n', '<leader>td', function()
        neotest.run.run { strategy = 'dap' }
      end, { desc = '[T]est [D]ebug nearest' })
    end,
  },
}
