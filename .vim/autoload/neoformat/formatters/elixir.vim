function! neoformat#formatters#elixir#enabled() abort
    return ['mixformat']
endfunction

function! neoformat#formatters#elixir#mixformat() abort
    return {
        \ 'env': ['ASDF_ELIXIR_VERSION=1.8.1-otp-21'],
        \ 'exe': 'mix',
        \ 'args': ['format', "-"],
        \ 'stdin': 1
        \ }
endfunction
