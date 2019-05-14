function! neoformat#formatters#python#enabled() abort
    return ['black']
endfunction

function! neoformat#formatters#python#black() abort
    return {
                \ 'exe': 'black',
                \ 'args': ['-', '--quiet'],
                \ 'stdin': 1
                \ }
endfunction
