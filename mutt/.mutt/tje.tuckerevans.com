set from="Tucker Evans <tje@tuckerevans.com>"
set hostname="tuckerevans.com"
set folder="~/Mail/tuckerevans/tje"
set mbox="~/Mail/tuckerevans/tje"
set record="~/Mail/tuckerevans/tje/sent"
set postponed="~/Mail/tuckerevans/tje/drafts"
set spoolfile="~/Mail/tuckerevans/tje/inbox"

set sendmail="/usr/bin/msmtp -a tje-tuckerevans"

color status black cyan

set alias_file = ~/.mutt/alias.tuckerevans.com
source $alias_file
