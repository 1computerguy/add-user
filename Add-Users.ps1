<#

** users.csv file format **
Name,SurName,Domain,Path,Password,Groups
First,Last,domain.com,"OU=Top folder,OU=Domain Users,DC=domain,DC=com",SomeSecurePassword!@# ,"Group 1,Group 2,Group 3"

#>

import-module ActiveDirectory
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn

$users = "C:\users\bccsadministrator\Documents\users.csv"

import-csv $users | % {
	$acct = "$($_.Name)`.$($_.SurName)"
	$full = "$($_.Name)` $($_.SurName)"
    $email = "$($acct)`@$($_.Domain)"
	New-AdUser -Name $full -Surname $_.SurName -GivenName $_.Name -DisplayName $full -samAccountName $acct -AccountPassword $(ConvertTo-SecureString $_.Password -AsPlainText -Force) -Path $_.path -Enable $True -OtherAttributes @{mail=$email} -PasswordNeverExpires $True -CannotChangePassword $True -UserPrincipalName $email -PassThru

	($_.Groups).split(",") | % { Add-AdGroupMember -Identity $_ -Member $acct }

    # Check AD for creation of user and propogation before creating email Accounts
    # If Email creation line runs before account has propogated, then it will fail
    while (-not $AdUser0 {
        try {
            $AdUser = Get-AdUser $acct.Trim()
        } catch {
            sleep 10
        }
    }
    Enable-Mailbox -Identity $email -Alias $acct -DisplayName $full
}
