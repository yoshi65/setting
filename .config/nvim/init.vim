" .vimrcと同じ部分
" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 全ての数値を十進数として扱う
set nrformats=
" ビープ音を鳴らさない
set visualbell t_vb=
set noerrorbells


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest


" 検索系
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch


" キーマッピング系
" カーソルキー使用不可
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
 " jjで<ESC>
inoremap <silent> jj <ESC>
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk


" .vimrcと異なる部分"
  let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
  let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
  let g:python_host_prog = '/opt/local/bin/python2.7'
  let g:python3_host_prog = '/opt/local/bin/python3.6'

	" macのclipboardとyankを統一
	set clipboard=unnamed

  " dein {{{
  let s:dein_cache_dir = g:cache_home . '/dein'

  " reset augroup
  augroup MyAutoCmd
  autocmd!
  augroup END

  if &runtimepath !~# '/dein.vim'
  	let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

  " Auto Download
		if !isdirectory(s:dein_repo_dir)
  		call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  	endif

  " dein.vim をプラグインとして読み込む
  	execute 'set runtimepath^=' . s:dein_repo_dir
  endif

  " dein.vim settings
  let g:dein#install_max_processes = 16
  let g:dein#install_progress_type = 'title'
  let g:dein#install_message_type = 'none'
  let g:dein#enable_notification = 1

  if dein#load_state(s:dein_cache_dir)
		call dein#begin(s:dein_cache_dir)

  	let s:toml_dir = g:config_home . '/dein'

  	call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  	call dein#load_toml(s:toml_dir . '/clang.toml', {'lazy': 0})
  	call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

  	call dein#end()
		call dein#save_state()
  endif

  if has('vim_starting') && dein#check_install()
		call dein#install()
  endif
  " }}}

" gg=Gで`autopep8`でindent整理
autocmd FileType python setlocal equalprg=autopep8\ -
