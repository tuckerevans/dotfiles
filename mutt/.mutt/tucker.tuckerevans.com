set from="Tucker Evans <tucker@tuckerevans.com>"
set hostname="tuckerevans.com"
set folder="~/Mail/tuckerevans/tucker"
set mbox="~/Mail/tuckerevans/tucker"
set record="~/Mail/tuckerevans/tucker/sent"
set postponed="~/Mail/tuckerevans/tucker/drafts"
set spoolfile="~/Mail/tuckerevans/tucker/inbox"

set sendmail="/usr/bin/msmtp -a tucker-tuckerevans"

color status black magenta

set alias_file = ~/.mutt/alias.tuckerevans.com
source $alias_file
