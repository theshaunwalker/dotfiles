#add each topic folder to fpath so that they can add functions and completion scripts
for topic_folder ($DOTFILES/*/functions) if [ -d $topic_folder ]; then  fpath=($topic_folder $fpath); fi;
#autoload the filenames otherwise they wont be seen by zsh
autoload -U $DOTFILES/*/functions/*(:t)