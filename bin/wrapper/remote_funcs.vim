function RemoteStart(socket)
    let mode = filereadable(a:socket)? 'pipe': 'tcp'
    return sockconnect(mode, a:socket, {'rpc': v:true})
endfunction

function RemoteMan(socket, vert, manpage)
    let conn = RemoteStart(a:socket)
    let cmd = a:vert == '1'? 'vert Man ': 'Man '
    call rpcrequest(conn, 'nvim_command', cmd . a:manpage)
    quit
endfunction

function RemoteVim(socket, mode, ...)
    let conn = RemoteStart(a:socket)
    let mode = a:mode == 'diff'? 'vert diffsplit': a:mode
    let escape_chars = ' \'
    let files = map(copy(a:000), 'escape(v:val, escape_chars)')

    call rpcrequest(conn, 'nvim_set_current_dir', getcwd())

    for f in files
        call rpcrequest(conn, 'nvim_command', mode . ' ' . f)
    endfor
    quit
endfunction
