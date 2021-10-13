function! ToggleFold()
     if &foldlevel >= 20
         "normal! zM<CR> (folds all)
         set foldlevel=0
     else
         "normal! zR<CR> (unfolds everything)
         set foldlevel=20
     endif
endfunction
