# Onion-Console
Web application for accessing Onion devices

## Setup on Omega
Follow the table below for information on setting up the Console on an Omega
| Repo File or Dir | Location on Omega           |
| ------------- | -------------|
| www/*     | /www/. |
| acl.d/onion-console.json      | /usr/share/rpcd/acl.d/onion-console.json      |
| rpcd/onion-console.sh | /usr/libexec/rpcd/onion-console      |

Run `/etc/init.d/rpcd restart` after copying rows 2 and 3
