# short aliases
alias e "$VISUAL"
alias g git
alias l 'ls -al'

# verbose stat
alias stat 'stat -x'

# mvim
alias mvim 'pipenv run /Applications/MacVim.app/Contents/bin/mvim'

# docker
alias dc docker-compose

# use vim colors for httpie
alias http 'http --style=vim'

# useful git WIP commands
alias wip 'git add .;git commit -m "WIP" --no-verify'
alias unwip 'git reset --soft HEAD~1; git reset .'

# keep count of how many cups of coffee I've had at work
alias cups 'echo (cat ~/.coffee) cups of coffee'
alias drink 'echo (math (cat ~/.coffee) + 1) > ~/.coffee; and cups'
