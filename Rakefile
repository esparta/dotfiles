DO_NOT_SYMLINK = %w[
  .gitignore
  extras
  Rakefile
  README.md
  LICENSE
]

def error(text)
  STDERR.puts "!  #{text}"
end

def info(text)
  STDOUT.puts "*  #{text}"
end

def info_rm(text)
  STDOUT.puts "x  #{text}"
end

is_symlink = proc { |file| File.symlink?(file) }
file_exist = proc { |file| File.exist?(file) }

task default: :install

desc 'Install dotfiles.'
task :install do
  Dir['**/*'].each do |file|
    source = File.join(Dir.pwd, file)
    next if File.directory?(source)
    next if DO_NOT_SYMLINK.include?(File.basename(source))

    target = File.join(Dir.home, ".#{file}")

    case target
    when is_symlink
      next if File.readlink(target) == source
      info_rm "Removing symlink #{target} --> #{symlink_to}"
      FileUtils.rm(target)
    when file_exist
      error <<-MSG.strip
      #{target} exists. Will not automatically overwrite a non-symlink.
       Overwrite (y/n)?
      MSG
      print '? '
      next unless STDIN.gets =~ /^y/i
      info_rm "Removing #{target}."
      FileUtils.rm_rf(target)
    else
      FileUtils.mkdir_p(File.split(target).first)
    end

    FileUtils.ln_s(source, target)
    info "Creating symlink: #{target} --> #{source}"
  end

  system 'git submodule update --init'
end
