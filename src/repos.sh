# repos.sh
# I like to have my open source projects really close to me
# This script loops my list of Frequently Used Projects (FUP)
# and fetch it locally.
SCRIPT_PATH=$(dirname $(realpath -s $0))
echo "I $(date +"%F %T") - Preparing the repos"
while IFS=, read -r branch origin target upstream
do
  target_directory="${HOME}/$target"
  echo "I $(date +"%F %T") - Starting clonning $origin"
  if $(git clone $origin $target_directory &> /dev/null) ; then
    echo "I $(date +"%F %T") - Done with $origin"
    if [ ! -z "$target" ]; then
      cd "$target_directory"
      git remote add upstream $upstream
      git pull upstream $branch
    fi
  else
    echo "Skiping $origin"
  fi
done < "$SCRIPT_PATH/repos/list.csv"

