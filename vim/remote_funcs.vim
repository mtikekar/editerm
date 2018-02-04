command! -nargs=+ RemoteVim :call <SID>RemoteVim(<f-args>)
command! -nargs=+ RemoteMan :call <SID>RemoteMan(<f-args>)
command! -nargs=1 RemoteStart :call <SID>RemoteStart(<f-args>)

function! s:RemoteStart(socket)
    let mode = filereadable(a:socket)? 'pipe': 'tcp'
    let s:conn = sockconnect(mode, a:socket, {'rpc': v:true})
endfunction

function! s:RemoteMan(...)
    if exists('$MANPATH')
        call rpcrequest(s:conn, 'nvim_command', "let $MANPATH = '" . $MANPATH . "'")
    endif
    call rpcrequest(s:conn, 'nvim_command', 'Man ' . join(a:000, ' '))
endfunction

function! s:RemoteVim(mode, ...)
    let mode = a:mode == 'diff'? 'vert diffsplit': a:mode
    let escape_chars = ' \'
    let files = map(copy(a:000), 'escape(v:val, escape_chars)')

    call writefile([mode] + files, "files.log", "a")
    call rpcrequest(s:conn, 'nvim_set_current_dir', getcwd())

    " Preserve the terminal tab if it would've been taken over
    " by one of the new files being opened
    if len(files) > 1 || a:mode == 'edit'
        call rpcrequest(s:conn, 'nvim_command', '-tabedit ' . files[0])
        unlet files[0]
    endif

    for f in files
        call rpcrequest(s:conn, 'nvim_command', mode . ' ' . f)
    endfor
endfunction
