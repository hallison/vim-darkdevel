set noignorecase

let b:plugin = {}
let b:plugin.name     = "darkdevel"
let b:plugin.language = "Vim"
let b:plugin.author   = "Hallison Batista <hallison.batista@gmail.com>"
let b:plugin.url      = "http://github.com/depuracao/vim-darkdevel"
let b:plugin.scm      = "http://github.com/depuracao/vim-darkdevel.git"
let b:plugin.version  = system("git tag | sort | tail -1 | tr -d '[v\n]'")
let b:plugin.release  = system("git log --format='%ai%n' v".b:plugin.version."| head -1 | tr -d '\n'")
let b:plugin.remark   = "Dark color scheme for Vim editor"

execute 1

while search("b:plugin.", "w", line("$")) > 0
  let s:key    = matchstr(getline("."), 'b\:plugin\.\w\+')
  let s:value  = eval(s:key)
  let s:value  = substitute(s:value, "\?", '\\\?', "") " fix to url values
  let s:regexp = "s?".s:key."?".s:value."?g"
  execute s:regexp
  execute 1
endwhile

update

