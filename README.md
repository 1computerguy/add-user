# add-user
Script to bulk add users and create associated MS Exchange email accounts.

This script uses the Microsoft Active Directory and Exchange Management Shell modules to add users from a CSV file to the domain and then create an Exchange email account for the user.

#### CSV File format (also in the source notes):
Name,SurName,Domain,Path,Password,Groups <br>
First,Last,domain.com,"OU=Top folder,OU=Domain Users,DC=domain,DC=com",SomeSecurePassword!@# ,"Group 1,Group 2,Group 3"


#### PowerShell Requirements in order to function:
  - PowerShell - Exchange Management Shell module
  - PowerShell - Active Directory module
