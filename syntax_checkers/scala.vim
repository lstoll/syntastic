"============================================================================
"File:        scala.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Lincoln Stoll <l@lds.li>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"Requires an ant task like:
" <target name="check-syntax" depends="init">
"    <mkdir dir="${build.dir}"   />
"    <fsc sourcepathref="sources"
"      srcdir='${basedir}'
"            destdir="${build.dir}"
"            failonerror="false"
"            classpathref="build.classpath">
"            <include name="**/${CHK_SOURCES}" />
"    </fsc>
"  </target>
" 
"============================================================================
if exists("loaded_scala_syntax_checker")
    finish
endif
let loaded_scala_syntax_checker = 1

"bail if the user doesnt have ruby installed
if !executable("ant")
    finish
endif

function! SyntaxCheckers_scala_GetLocList()
    let makeprg = 'ant -find build.xml -emacs check-syntax -DCHK_SOURCES='.shellescape(expand('%:t'))
    let errorformat = '%E%f:%l: error: %m,%Z%p^,%-G,%-GSearching for%.%#,%-G%.%#:,%-GBuildfile%.%#,%-GCompiling%.%#,%-G%.%#errors found,%-GBUILD SUCCESSFUL,%-GTotal time%.%#'

    return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
endfunction
