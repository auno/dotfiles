setlocal foldmethod=expr
setlocal textwidth=100
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab

function s:MarkdownNotesHeadingFoldExpr()
  if exists("b:__markdown_heading_fold_expr_last_tick") == 0
    let b:__markdown_heading_fold_expr_last_tick = -1
  endif

  if b:__markdown_heading_fold_expr_last_tick != b:changedtick
    let b:__markdown_heading_fold_expr_last_tick = b:changedtick
    let b:__markdown_heading_fold_expr_levels = {}

    let headings = matchbufline(bufnr(), '^#\+', 1, '$')->mapnew({ i, m -> [m.lnum, len(m.text)] })

    if getline("$") =~ "^\s*<!--.*vim:.*-->\s*$"
      let headings += [[line('$'), 0]]
    endif

    let prev_level = 0

    for [line_number, level] in headings
      if level > &foldnestmax
        continue
      endif

      let fold_start_line_number = (line_number > 1 && getline(line_number - 1) == "") ? line_number - 1 : line_number
      let b:__markdown_heading_fold_expr_levels[fold_start_line_number] = '>'.level

      if level < prev_level
        let prev_fold_end_line_number = fold_start_line_number

        while prev_fold_end_line_number > 1 && getline(prev_fold_end_line_number - 1) == ""
          let prev_fold_end_line_number = prev_fold_end_line_number - 1
        endwhile

        if prev_fold_end_line_number < fold_start_line_number
          let closing_level = prev_level

          while closing_level > level
            let b:__markdown_heading_fold_expr_levels[prev_fold_end_line_number - 1] = '<'.closing_level
            let closing_level = closing_level - 1
          endwhile
        endif
      endif

      let prev_level = level
    endfor
  endif

  if b:__markdown_heading_fold_expr_levels->has_key(v:lnum)
    return b:__markdown_heading_fold_expr_levels[v:lnum]
  endif

  return '='
endfunction

function s:MarkdownNotesHeadingNewlinesFormatter()
  let l:pos = winsaveview()
  " Apply two blank lines above each heading
  %s/.\zs\n\+#/\1\r\r\r#/
  call winrestview(l:pos)
endfunction

setlocal foldexpr=s:MarkdownNotesHeadingFoldExpr()

autocmd BufWritePre <buffer> :call s:MarkdownNotesHeadingNewlinesFormatter()
