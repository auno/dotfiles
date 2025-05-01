setlocal shiftwidth=2
setlocal tabstop=2

function s:MarkdownHeadingFoldExpr()
  if exists("b:__markdown_heading_fold_expr_last_tick") == 0
    let b:__markdown_heading_fold_expr_last_tick = -1
    let b:__markdown_heading_fold_expr_last_fold_end = line("$")
  endif

  if b:__markdown_heading_fold_expr_last_tick != b:changedtick
    let b:__markdown_heading_fold_expr_last_tick = b:changedtick

    if getline("$") =~ "^\s*<!--.*vim:.*-->\s*$"
      let b:__markdown_heading_fold_expr_last_fold_end = (line("$") - 1)

      while b:__markdown_heading_fold_expr_last_fold_end > 0 && getline(b:__markdown_heading_fold_expr_last_fold_end) == ""
        let b:__markdown_heading_fold_expr_last_fold_end = b:__markdown_heading_fold_expr_last_fold_end - 1
      endwhile
    else
      let b:__markdown_heading_fold_expr_last_fold_end = line("$");
    endif
  endif

  if v:lnum > b:__markdown_heading_fold_expr_last_fold_end
    return 0
  endif

  let line = getline(v:lnum)
  
  if line[0] != '#'
    return '='
  endif

  let headingLevel = match(line, "[^#]")

  if headingLevel > &foldnestmax
    return '='
  endif

  return '>'.headingLevel
endfunction

setlocal foldexpr=s:MarkdownHeadingFoldExpr()
