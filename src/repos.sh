# repos.sh
# I like to have my open source projects really close to me
# This script loops my list of Frequently Used Projects (FUP)
# and fetch it locally.
SCRIPT_PATH=$(dirname $(realpath -s $0))
echo "I $(date +"%F %T") - Preparing the repos"
while IFS=, read -r origin_name branch repo_url target upstream
do
  target_directory="${HOME}/$target"
  echo "I $(date +"%F %T") - Starting clonning $repo_url"
  if $(git clone --origin $origin_name $repo_url $target_directory &> /dev/null) ; then
    echo "I $(date +"%F %T") - Done with $repo_url"
    if [ ! -z "$target" ]; then
      cd "$target_directory"
      git remote add upstream $upstream
      git pull upstream $branch
    fi
  else
    echo "Skiping $repo_url"
  fi
done < "$SCRIPT_PATH/repos/list.csv"

