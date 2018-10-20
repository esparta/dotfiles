function fetch_upstream --description='Loop current directories to get the
updates from upstream'
  for directory in (find * -prune -type d)
    echo "CD to $directory"
    cd "$directory"
    if [ -d .git ]
      git fetch upstream
    end
    cd ..
  end
end
