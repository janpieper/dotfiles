function! neoformat#formatters#elixir#enabled() abort
    return ['mixformat']
endfunction

function! neoformat#formatters#elixir#mixformat() abort
    return {
        \ 'env': ['ASDF_ELIXIR_VERSION=1.6.0'],
        \ 'exe': 'mix',
        \ 'args': ['format', "-"],
        \ 'stdin': 1
        \ }
endfunction
