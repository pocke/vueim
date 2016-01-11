export PATH := $(HOME)/.vim/bundle/vim-themis/bin/:$(PATH)

spec:
	themis --reporter spec

depends:
	git clone https://github.com/thinca/vim-themis             ~/.vim/bundle/vim-themis
	git clone https://github.com/vim-jp/vital.vim              ~/.vim/bundle/vital.vim
	git clone https://github.com/haya14busa/vital-vimlcompiler ~/.vim/bundle/vital-vimlcompiler
	git clone https://github.com/haya14busa/vital-power-assert ~/.vim/bundle/vital-power-assert
