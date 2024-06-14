# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

alias ga="git add"                                                                                                                                                                                                      
alias gb="git branch"                                                                                                                                                                                                   
alias gc="git commit -v"                                                                                                                                                                                                
alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'                                                                                                                                                                                                
alias gd="git diff"                                                                                                                                                                                                     
alias gdca='git diff --cached'
alias gf="git fetch"                                                                                                                                                                                                    
alias gl='git pull'                                                                                                                                                                                                     
alias gm="git merge"                                                                                                                                                                                                    
alias gp="git push"                                                                                                                                                                                                     
alias gst='git status' 
alias gunwip='git log -n 1 | grep -q -c "\--wip--" && git reset HEAD~1'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
