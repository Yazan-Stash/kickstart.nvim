local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require('luasnip.extras').rep

return {
  -- Closure (clj)
  s('clj', {
    t('function('),
    i(1),
    t({ '){', '\t' }),
    i(2),
    t({ '', '}' }),
  }),

  -- Dump and Die (dd)
  s('dd', {
    t('dd('),
    i(1),
    t(');'),
  }),

  -- Factory (fcy)
  s('fcy', {
    t('factory()->create('),
    i(1),
    t(');'),
    i(2),
  }),

  -- Public Method (met)
  s('met', {
    t('public function '),
    i(1),
    t('('),
    i(2),
    t({ ')', '{', '\t' }),
    i(3),
    t({ '', '}' }),
  }),

  -- Protected Method (pmet)
  s('pmet', {
    t('protected function '),
    i(1),
    t('('),
    i(2),
    t({ ')', '{', '\t' }),
    i(3),
    t({ '', '}' }),
  }),

  -- Factory State Method (smet)
  s('smet', {
    t('public function '),
    i(1),
    t('('),
    i(2),
    t({ ')', '{', '\treturn $this->state(function (array $attributes) {', '\t    return [', '\t        ' }),
    i(3),
    t({ '', '\t    ];', '\t});', '}' }),
  }),

  -- PHPUnit Setup (setup)
  s('setup', {
    t({ 'public function setup(): void', '{', '    parent::setup();', '', '\t' }),
    i(1),
    t({ '', '}', '' }),
  }),

  -- Test Method (tmet)
  s('tmet', {
    t({ '#[Test]', 'public function ' }),
    i(1),
    t({ '()', '{', '\t' }),
    i(2),
    t({ '', '}' }),
  }),

  -- Todo Test Method (ttmet)
  s('ttmet', {
    t({ '#[Test]', 'public function ' }),
    i(1),
    t({ '()', '{', '\t$this->markTestIncomplete("Todo: ' }),
    rep(1),
    t({ '");', '}' }),
  }),

  -- Without Exception Handling (nohandling)
  s('nohandling', {
    t('$this->withoutExceptionHandling();'),
  }),

  -- Foreign Relation (foreignRelation)
  s('foreignRelation', {
    t('$table->foreign(\''),
    i(1),
    t({ '_id\')', '\t->references(' }),
    i(2, '\'id\''),
    t({ ')->on(\'' }),
    f(function(args)
      return args[1][1] .. 's'
    end, { 1 }),
    t({ '\')', '\t->onUpdate(\'cascade\')->onDelete(\'cascade\');' }),
  }),

  -- This ($ -> this->)
  s('$', {
    t('this->'),
  }),

  -- Test Case (tcase)
  s('tcase', {
    t({ '<?php', '', 'namespace Tests\\Feature\\Jobs;', '', 'use Illuminate\\Foundation\\Testing\\RefreshDatabase;', 'use PHPUnit\\Framework\\Attributes\\Test;', 'use Tests\\TestCase;', '', 'class ' }),
    i(1, 'Test'),
    t({ ' extends TestCase', '{', '    use RefreshDatabase;', '', '    #[Test]', '    public function itAsserts()', '    {', '        $this->markTestIncomplete(\'Todo\');', '    }', '}' }),
  }),

  -- Crawler Test Method (ctmet)
  s('ctmet', {
    t({ '<?php', '', 'namespace Tests\\Crawler;', '', 'use Tests\\TestCase;', 'use Illuminate\\Foundation\\Testing\\WithFaker;', 'use Illuminate\\Foundation\\Testing\\RefreshDatabase;', '', 'class ' }),
    i(1),
    t({ 'Test extends TestCase', '{', '    /** @test */', '    public function can_extract_heading_from_article()', '    {', '    \t', '    }', '    ', '    /** @test */', '    public function can_extract_body_from_article()', '    {', '    \t', '    }', '    ', '    /** @test */', '    public function can_extract_date_published_from_article()', '    {', '    \t', '    }', '', '    /** @test */', '    public function can_extract_images_from_article()', '    {', '    \t', '    }', '}' }),
  }),
}
