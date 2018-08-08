# Adapted from the function by @xfix on the following GitHub issue:
# https://github.com/fish-shell/fish-shell/issues/114

function fish_logo --description 'Draw the fish shell logo'
  set c1 (set_color f00)
  set c2 (set_color ff7f00)
  set c3 (set_color ff0)

  echo '                 '$c1'___
  ___======____='$c2'-'$c3'-'$c2'-='$c1')
/T            \_'$c3'--='$c2'=='$c1')
[ \ '$c2'('$c3'0'$c2')   '$c1'\~    \_'$c3'-='$c2'='$c1')
 \      / )J'$c2'~~    '$c1'\\'$c3'-='$c1')
  \\\\___/  )JJ'$c2'~'$c3'~~   '$c1'\)
   \_____/JJJ'$c2'~~'$c3'~~    '$c1'\\
   '$c2'/ '$c1'\  '$c3', \\'$c1'J'$c2'~~~'$c3'~~     '$c2'\\
  (-'$c3'\)'$c1'\='$c2'|'$c3'\\\\\\'$c2'~~'$c3'~~       '$c2'L_'$c3'_
  '$c2'('$c1'\\'$c2'\\)  ('$c3'\\'$c2'\\\)'$c1'_           '$c3'\=='$c2'__
   '$c1'\V    '$c2'\\\\'$c1'\) =='$c2'=_____   '$c3'\\\\\\\\'$c2'\\\\
          '$c1'\V)     \_) '$c2'\\\\'$c3'\\\\JJ\\'$c2'J\)
                      '$c1'/'$c2'J'$c3'\\'$c2'J'$c1'T\\'$c2'JJJ'$c1'J)
                      (J'$c2'JJ'$c1'| \UUU)
                       (UU)'(set_color normal)
end
