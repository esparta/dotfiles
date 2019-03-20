# Get all the files (no directories),
# excluding
#  - hidden files
#  - src folder
for entry in $(find -L . -type f -not -path '*/\.*' -not -path "./src/*")
do
  thefile=${entry:2}

  case "$thefile" in
    $0 | "README.md" \
    | "LICENSE" | "Rakefile" )
      continue
      ;;
  esac

   target=$HOME/."$thefile"
   if [ -L "$target" ]
   then
     symlink_to=$(readlink $target)

     if [ $symlink_to == $PWD/$thefile ]
     then
       continue
     fi
     echo "Removing symlink $target --> $symlink_to"
     rm "$target"
   fi

   if [ -e "$target" ]; then
      cat <<MSG >&2
 $target exists. Will not automatically overwrite a non-symlink. Overwrite (y/n)?
MSG
      read answer
      if [ "$answer" != "${answer#[Yy]}" ] ;then
        # We are deleting a file, so silently do a backup
        cp "$target" "$target"_$(date +"%Y_%m_%d_%H%M%S")
        echo "Removing $target"
        rm -rf "$target"
      else
        continue
      fi
   else
     new_folder=$(dirname "$target")
     if [ ! -d "$new_folder" ]
     then
       echo "Creating: $(dirname $target)"
       mkdir -p "$new_folder"
     fi
   fi

   echo "Linking $target -> $PWD/$thefile"
   ln -s $PWD/"$thefile" "$target"
done
