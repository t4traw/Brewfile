DOTPATH=$HOME/ghq/github.com/t4traw/dotfiles
for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue
    ln -sf ${DOTPATH}/${f} ${HOME}/${f}
done