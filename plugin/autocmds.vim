" plugin/autocmds.vim


augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

augroup startUp
    autocmd!

    autocmd VimEnter * call darkmodesocket#listenForLights()
augroup END
