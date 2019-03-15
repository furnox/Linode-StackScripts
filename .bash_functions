#
# Utility to harness popd
#
po(){
   if [[ -z "$1" ]]; then
       popd 1>/dev/null;dirs -v;
   else
       if [[ $1 =~ ^[\+-][0-9]+ ]]; then
           cda=$(dirs "${1}")
           \cd "${cda}"
           popd "$1" 1>/dev/null;dirs -v;
       else
           if [[ $1 =~ ^[0-9]+ ]]; then
               cda=$(dirs "+${1}")
               \cd "${cda}"
               popd "+$1" 1>/dev/null;dirs -v;
           else
               echo "Invalid parameters"
           fi
       fi
   fi
}

#
# Utility to harness pushd
#
pu(){
   if [[ -z "$1" ]]; then
       pushd . -n 1>/dev/null;dirs -v;
   else
       pushd "$1" 1>/dev/null;dirs -v;
   fi
}

#
# Utility to detect if in a git directory and what the branch is
#
__gitbranch() {
   BRANCH=$( __git_ps1 "%s" )
   if [ -n "$BRANCH" ]; then
      if [ "$BRANCH" == "()" ]; then
         TAG=$(\git describe --tag 2>/dev/null | sed -r 's/-[0-9]+-[a-z0-9]{8}$//')
         if [ -n "$TAG" ]; then
            BRANCH="[Tag: **${TAG}**]"
         else
            BRANCH="[no branch]"
         fi
      else
         BRANCH="[$BRANCH]"
         if [ -n "$(\git status -s 2>/dev/null)" ]; then
            BRANCH=${BRANCH/]/*]}
         fi
      fi
      echo "$BRANCH"
   else
      echo ""
   fi
}

#
# Utility to quickly move up a directory structure
#
cdx_opts(){
   if [[ $1 =~ \.{3,} ]]; then
      local test=${1:1} path=""
      while [ -n "${test}" ]; do
         if [[ "${test:0:1}" == '/' ]]; then
            path="${path}${test}"
            break
         fi
         path="${path}../"
         test=${test#?}
      done
      echo "${path}"
   else
      echo "${1}"
   fi
}
cdx(){
   if [ -z "${1}" ]; then
      \cd
   else
      \cd "`cdx_opts "${1}"`"
   fi
}
alias cd="cdx $1"


# explain.sh begins
explain () {
    if [ "$#" -eq 0 ]; then
        while read  -p "Command: " cmd; do
            curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
        done
        echo -e "\n"
    elif [ "$#" -eq 1 ]; then
        curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
    else
        echo "Usage"
        echo "explain                  interactive mode."
        echo "explain 'cmd -o | ...'   quoted command to be explainedt."
    fi
}