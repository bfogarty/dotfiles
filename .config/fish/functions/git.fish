function git --description "Wrap git to prevent me from being a moron"
     if [ "$argv[1]" = "reset" ]; and [ (string lower \"$argv[2]\") = \"--hard\" ]
          echo "Are you being a moron again?"
          read i
          if [ "$i" = "no" ]
               command git $argv
          end
     else
          command git $argv
     end
end
