set from = "tuckerevans24@gmail.com"
set hostname = "gmail.com"
set folder = "~/Mail/gmail"
set mbox = "~/Mail/gmail"
set record = "~/Mail/gmail/sent"
set postponed = "~/Mail/gmail/Drafts"
set spoolfile = "~/Mail/gmail/inbox"

set sendmail = "/usr/bin/msmtp -a default"

color status black blue
