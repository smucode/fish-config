function fish_prompt
 
  if [ $status = 0 ]
    set st (set_color -o 27AE60)
  else
    set st (set_color -o red)
  end
    
  #if not set -q -g __fish_smu_functions_defined
  #  set -g __fish_smu_functions_defined
 
    function _git_branch_name
      echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    end
  
    function _is_git_dirty
      echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end
 
    function _is_git_added
      echo (git status -s ^/dev/null | sed -e '/^[AM] .*$/d')
    end
  #end
 
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o 2980B9)
  set -l normal (set_color BDC3C7)
  set -l gray (set_color -o 111)
  set -l green (set_color -o 16A085)
 
  set -l arrow "$red∴ "
  set -l cwd (pwd|sed "s=$HOME=~=")
 
  set -l time (date "+%H:%M")
 
  if [ (_git_branch_name) ]
    set gcol $gray
 
    if [ (_is_git_dirty) ]
      if [ (_is_git_added) ]
        set gcol $blue
      else
        set gcol $green
      end
    end
 
    set -l git_branch (_git_branch_name)
    set git_info "$gcol [$git_branch]"
  end
 
  echo 
  echo -s $st '( ' $normal $gray $time ' ' $normal $cwd $git_info ' ' $st ') ' $normal
end
