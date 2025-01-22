local wk = require('which-key')
wk.setup({
  delay = 2000
})
wk.add({
	{"<Leader>c", group = "CodeCompanion" },
	{"<Leader>g", group = "Git"},
})
