command! -nargs=+ RemoteVim :call <SID>RemoteVim(<f-args>)
command! -nargs=+ RemoteMan :call <SID>RemoteMan(<f-args>)
command! -nargs=1 RemoteStart :call <SID>RemoteStart(<f-args>)

function! s:RemoteStart(socket)
    let mode = filereadable(a:socket)? 'pipe': 'tcp'
    let s:conn = sockconnect(mode, a:socket, {'rpc': v:true})
endfunction

function! s:RemoteMan(vert, ...)
    let cmd = a:vert == '1'? 'vert Man ': 'Man '
    call rpcrequest(s:conn, 'nvim_command', cmd . join(a:000, ' '))
endfunction

function! s:RemoteVim(mode, ...)
    let mode = a:mode == 'diff'? 'vert diffsplit': a:mode
    let escape_chars = ' \'
    let files = map(copy(a:000), 'escape(v:val, escape_chars)')

    call rpcrequest(s:conn, 'nvim_set_current_dir', getcwd())

    for f in files
        call rpcrequest(s:conn, 'nvim_command', mode . ' ' . f)
    endfor
endfunction
