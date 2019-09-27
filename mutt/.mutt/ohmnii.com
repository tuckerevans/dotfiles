set from="Tucker Evans <tucker@ohmnii.com>"
set hostname="ohmnii.com"
set folder="~/Mail/ohmnii"
set mbox="~/Mail/ohmnii"
set record="~/Mail/ohmnii/sent"
set postponed="~/Mail/ohmnii/drafts"
set spoolfile="~/Mail/ohmnii/inbox"

set sendmail="/usr/bin/msmtp -a ohmnii"

color status black green

