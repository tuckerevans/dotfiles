set from="Tucker Evans <tje@tuckerevans.com>"
set hostname="tuckerevans.com"
set folder="~/Mail/tuckerevans"
set mbox="~/Mail/tuckerevans"
set record="~/Mail/tuckerevans/sent"
set postponed="~/Mail/tuckerevans/drafts"
set spoolfile="~/Mail/tuckerevans/inbox"

set sendmail="/usr/bin/msmtp -a tuckerevans"

color status black cyan
