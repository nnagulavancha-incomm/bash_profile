#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  1.   Environment Configuration
#  2.   Make Terminal Better (remapping defaults and adding functionality)
#  3.   File and Folder Management
#  4.   Searching
#  5.   Process Management
#  6.   Networking
#  7.   System Operations & Information
#  8.   Web Development
#  9.   Reminders & Notes
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Colors
#   ------------------------------------------------------------
    export      NOCOLOR="\033[0m"
    export        BLACK="\033[0;30m"
    export    DARK_GRAY="\033[1;30m"
    export         BLUE="\033[0;34m"
    export   LIGHT_BLUE="\033[1;34m"
    export        GREEN="\033[0;32m"
    export  LIGHT_GREEN="\033[1;32m"
    export         CYAN="\033[0;36m"
    export   LIGHT_CYAN="\033[1;36m"
    export          RED="\033[0;31m"
    export    LIGHT_RED="\033[1;31m"
    export       PURPLE="\033[0;35m"
    export LIGHT_PURPLE="\033[1;35m"
    export BROWN_ORANGE="\033[0;33m"
    export       YELLOW="\033[1;33m"
    export   LIGHT_GRAY="\033[0;37m"
    export        WHITE="\033[1;37m"

    export LESS_TERMCAP_mb=$'\E'${RED:4}          # begin blinking
    export LESS_TERMCAP_md=$'\E'${LIGHT_RED:4}    # begin bold
    export LESS_TERMCAP_me=$'\E'${NOCOLOR:4}      # end mode
    export LESS_TERMCAP_se=$'\E'${NOCOLOR:4}      # end standout-mode
    export LESS_TERMCAP_so=$'\E[01;44;33m'        # begin standout-mode - info box
    export LESS_TERMCAP_ue=$'\E'${NOCOLOR:4}      # end underline
    export LESS_TERMCAP_us=$'\E'${LIGHT_GREEN:4}  # begin underline

#   Add color to terminal
#   (this is all commented out as I use Mac Terminal Profiles)
#   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#   ------------------------------------------------------------
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad

#   Change Prompt
#   ------------------------------------------------------------
    function prompt_command() {
     DATE=$(date +%H:%M:%S)
     UNAME="${CYAN}${USER}@$(hostname -s)${NOCOLOR}"
     LN="┏━━[$DATE]━━[$UNAME]━━"
     FILL="`printf -vch "%${COLUMNS}s" ""; printf "%s" "${ch// /━}"`"
     echo -e "${LN}${FILL:((${#LN}-16))}┓"
    }
    export PROMPT_COMMAND=prompt_command
    PS1="┃  \[${YELLOW}\]\w\[${NOCOLOR}\]\n"
    export PS1="${PS1}┗━\[${LIGHT_RED}\]►\[${NOCOLOR}\] "
    export PS2="┗━\[${YELLOW}\]►\[${NOCOLOR}\] "

#   Set Paths
#   ------------------------------------------------------------
    # export PATH="$PATH:/usr/local/bin/"
    # export PATH="/usr/local/git/bin:/sw/bin/:/usr/local/bin:/usr/local/:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
    export PATH="/opt/local/bin:/opt/local/sbin:/opt/scripts":$PATH
    export PYTHONPATH="/usr/bin/python"
    # Added by the Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"
    export PATH="~/Library/Maven/apache-maven-3.5.2/bin:$PATH" #maven path
    export PATH="~/Library/Android/sdk:$PATH" # Android path
    export PATH="~/Library/Android/sdk/platform-tools:$PATH" #Android platform tools
    export PATH="~//Library/Android/sdk/tools:$PATH" #Android emulator
    export PATH="/usr/local:$PATH"
    export PATH="/Users/nnagulavancha/Documents/Flutter/flutter/bin:$PATH"
    export JAVA_HOME=$(/usr/libexec/java_home)

#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------
    export EDITOR=/usr/bin/vi

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
    export BLOCKSIZE=1k

#   Control history
#   ------------------------------------------------------------
    export HISTCONTROL=ignoreboth:erasedups
    export HISTSIZE=5000

#   tab completion for ssh hosts
    if [ -f ~/.ssh/known_hosts ]; then
        complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
    fi

    # Tab complete for sudo
    #complete -cf sudo
    # Make tab-completion case-sensitive
    #alias case_sensitive_completition='bind "set completion-ignore-case off"'
    # "Show the ~/Library folder"
    # chflags nohidden ~/Library

#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------
    alias as='emulator -avd Nexus_6_API_25'   # launch android simulator
    alias is="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/" #iosSimulator
    alias dodo="pmset sleepnow"
    alias cp='cp -iv'                           # Preferred 'cp' implementation
    alias mv='mv -iv'                           # Preferred 'mv' implementation
    alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
    alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
    alias less='less -Rc'                       # Preferred 'less' implementation
    cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
    alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
    alias ..='cd ../'                           # Go back 1 directory level
    alias .2='cd ../../'                       # Go back 2 directory levels
    alias .3='cd ../../../'                     # Go back 3 directory levels
    alias .4='cd ../../../../'                  # Go back 4 directory levels
    alias .5='cd ../../../../../'               # Go back 5 directory levels
    alias .6='cd ../../../../../../'            # Go back 6 directory levels
    alias edit='subl'                           # edit:         Opens any file in sublime editor
    alias s='subl'                              #               Opens any file in sublime editor
    alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
    alias fcd='open -a Finder ./'               # f:            Opens current directory in MacOS Finder
    alias ~="cd ~"                              # ~:            Go Home
                                                # c:            Clear terminal display
    # alias c="osascript -e 'tell application \"System Events\" to keystroke \"k\" using command down'"
    alias c="clear && printf '\e[3J'"           # faster clear
    # alias which='type -all'                   # which:        Find executables
    alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
    alias show_options='shopt'                  # Show_options: display bash options settings
    alias fixtty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
    mkcd () { mkdir -p "$1" && cd "$1"; }       # mkcd:          Makes new Dir and jumps inside
    trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
    ql () { qlmanage -px "$*" >& /dev/null; }   # ql:           Opens any file in MacOS Quicklook Preview
    alias DT='tee ~/Desktop/terminalOut.txt'    # DT, DM:       Pipe content to file on MacOS Desktop or MenuBar
    alias DM='DT;~/Documents/Scripts/tail.py ~/Desktop/terminalOut.txt'
    title () { echo -ne "\033]0;$1\007"; }      # Set tab tite in Terminal.app
    alias reload="source ~/.bash_profile"       # reload profile
    alias python=python3
    alias pip=pip3

#   lr:  Full Recursive Directory Listing aka tree
#   ------------------------------------------
    alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.
#           Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less -r
    }

#   sudoapp: Runs .app with root privileges
#   --------------------------------------------------------------------
    SUDOUSER="root"
    sudoapp () {
        sudo -u $SUDOUSER "$1/Contents/MacOS/$(defaults read "$1/Contents/Info.plist" CFBundleExecutable)" $2
    }

    alias vlc=/Applications/VLC.app/Contents/MacOS/VLC


#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

    zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
# alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
# alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
# alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
# alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }
    # only show dot files
    alias lsh="ls -ld .??*"
    # Find files and ignore directories
    function ff(){
        find . -iname $1 | grep -v .svn | grep -v .sass-cache
    }

    function fif(){
	    if [ "$#" -eq 1 ]; then
		    grep -nr $1 . --color
	    else
		    s `grep -nr $1 . | sed -n $2p | cut -d: -f-2`
	    fi

    }
    
    function tree(){
	    pwd
	    ls -R | grep ":$" |   \
	    sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
    }
   # rename all the files which contain uppercase letters to lowercase in the current folder 
    function filestolower(){
        read -p "This will rename all the files and directories to lowercase in the current folder, continue? [y/n]: " letsdothis
        if [ "$letsdothis" = "y" ] || [ "$letsdothis" = "Y" ]; then
            for x in `ls`
                do
                skip=false
                if [ -d $x ]; then
	                read -p "'$x' is a folder, rename it? [y/n]: " renamedir
	                if [ "$renamedir" = "n" ] || [ "$renameDir" = "N" ]; then
	                    skip=true
	                fi
                fi
                if [ "$skip" == "false" ]; then
                    lc=`echo $x  | tr '[A-Z]' '[a-z]'`
                    if [ $lc != $x ]; then
                        echo "renaming $x -> $lc"
                        mv $x $lc
                    fi
                fi
            done
        fi
    }

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       /Applications/Keka.app/Contents/Resources/kekaunrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        /Applications/Keka.app/Contents/Resources/keka7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }


#   ---------------------------
#   4.  SEARCHING
#   ---------------------------

    alias qfind="find . -name "                 # qfind:    Quickly search for file
#    ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
    ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
    ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }


#   ---------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    # findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    # alias memHogsTop='top -l 1 -o rsize | head -20'
    # alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    # alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

    # alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
    # your public ip
    alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
    # your local ip
    alias localip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"

    alias lsnet='sudo lsof -i'                             # lsnet:      Show all open TCP/IP sockets
    alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
    alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
    # alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
    # alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
    # alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
    # alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
    alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
    alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${GREEN}$HOSTNAME${NOCOLOR}"
        echo -e "\nAdditionnal information:$NOCOLOR " ; uname -a
        echo -e "\n${RED}Users logged on:$NOCOLOR " ; w -h
        echo -e "\n${RED}Current date :$NOCOLOR " ; date
        echo -e "\n${RED}Machine stats :$NOCOLOR " ; uptime
        echo -e "\n${RED}Current network location :$NOCOLOR " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NOCOLOR " ;ip
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }
    
    function sshKeyGen(){

        echo "What's the name of the Key (no spaced please) ? ";
        read name;

        echo "What's the email associated with it? ";
        read email;

        `ssh-keygen -t rsa -f ~/.ssh/id_rsa_$name -C "$email"`;

        ssh-add ~/.ssh/id_rsa_$name

        pbcopy < ~/.ssh/id_rsa_$name.pub;

        echo "SSH Key copied in your clipboard";

    }


#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

    # alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
    alias cleanup="find . -name '*.DS_Store' -type f -ls -delete && find . -name 'Thumbs.db' -type f -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
    alias def_finderShowHidden='defaults write com.apple.finder ShowAllFiles -bool YES'
    alias def_finderHideHidden='defaults write com.apple.finder ShowAllFiles -bool NO'

#   do not show crash report   
    alias def_nocrashreport='defaults write com.apple.CrashReporter DialogType none'
    alias def_crashreport='defaults write com.apple.CrashReporter DialogType crashreport'

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#    Since Mavericks, changes in .plist files are ignored in favor of a cached version
#    plist_fix cleans in-memory defaults cache so the actual .plist can be used
#   -----------------------------------------------------------------------------------
    alias plist_fix='killall cfprefsd'
    alias plist2xml='plutil -convert xml1 '

#   Fix Finder "Open with..." menu
    alias fix_open_with='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user;killall Finder;echo "Open With has been rebuilt, Finder will relaunch"'
    
#   ---------------------------------------
#   8.  WEB DEVELOPMENT
#   ---------------------------------------

#   alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
#   alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
#   alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
#   alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
#   alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs
    httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }


#   ---------------------------------------
#   9.  REMINDERS & NOTES
#   ---------------------------------------

#   remove_disk: spin down unneeded disk
#   ---------------------------------------
#   diskutil eject /dev/disk1s3

#   to change the password on an encrypted disk image:
#   ---------------------------------------
#   hdiutil chpass /path/to/the/diskimage

#   to mount a read-only disk image as read-write:
#   ---------------------------------------
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify

#   mounting a removable drive (of type msdos or hfs)
#   ---------------------------------------
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo

#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   ---------------------------------------
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat

#   to get second column and iterate with it
#   ps axu|grep ^test|while read a b c; do sudo kill "$b"; done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave

# git

alias gcp='git add *;git commit -m "\"code wars\"";git push origin master;'



