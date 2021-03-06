" Vim syntax file
" Language: Vue.js
" Maintainer: Eduardo San Martin Morote

if exists("b:current_syntax")
  finish
endif

if !exists("s:syntaxes")
  " Search available syntax files.
  function s:search_syntaxes(...)
    let syntaxes = {}
    let names = a:000
    for name in names
      let syntaxes[name] = 0
    endfor

    for path in split(&runtimepath, ',')
      if isdirectory(path . '/syntax')
        for name in names
          let syntaxes[name] = syntaxes[name] || filereadable(path . '/syntax/' . name . '.vim')
        endfor
      endif
    endfor
    return syntaxes
  endfunction

  let s:syntaxes = s:search_syntaxes('jade', 'coffee', 'stylus', 'sass', 'less')
endif


syntax include @HTML syntax/html.vim
unlet b:current_syntax
syntax region template keepend start=/^<template>/ end=/^<\/template>/ contains=@HTML fold

if s:syntaxes.jade
  syntax include @JADE syntax/jade.vim
  unlet b:current_syntax
  syntax region jade keepend start=/<template lang="[^"]*jade[^"]*">/ end="</template>" contains=@JADE fold
endif

syntax include @JS syntax/javascript.vim
unlet b:current_syntax
syntax region script keepend start=/<script>/ end="</script>" contains=@JS fold

if s:syntaxes.coffee
  syntax include @COFFEE syntax/coffee.vim
  unlet b:current_syntax
  " Matchgroup seems to be necessary for coffee
  syntax region coffee keepend matchgroup=Delimiter start="<script lang=\"coffee\">" end="</script>" contains=@COFFEE fold
endif

syntax include @CSS syntax/css.vim
unlet b:current_syntax
syntax region style keepend start=/<style\( \+scoped\)\?>/ end="</style>" contains=@CSS fold

if s:syntaxes.stylus
  syntax include @stylus syntax/stylus.vim
  unlet b:current_syntax
  syntax region stylus keepend start=/<style lang="[^"]*stylus[^"]*"\( \+scoped\)\?>/ end="</style>" contains=@stylus fold
endif

if s:syntaxes.sass
  syntax include @sass syntax/sass.vim
  unlet b:current_syntax
  syntax region sass keepend start=/<style\( \+scoped\)\? lang="[^"]*sass[^"]*"\( \+scoped\)\?>/ end="</style>" contains=@sass fold
endif

if s:syntaxes.less
  syntax include @less syntax/less.vim
  unlet b:current_syntax
  syntax region less keepend matchgroup=PreProc start=/<style\%( \+scoped\)\? lang="less"\%( \+scoped\)\?>/ end="</style>" contains=@less fold
endif

let b:current_syntax = "vue"
