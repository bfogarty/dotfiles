# short aliases
alias e "$VISUAL"
alias g git
alias l 'ls -al'

# verbose stat
alias stat 'stat -x'

# keep count of how many cups of coffee I've had at work
alias cups 'echo (cat ~/.coffee) cups of coffee'
alias drink 'echo (math (cat ~/.coffee) + 1) > ~/.coffee; and cups'
