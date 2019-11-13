##   (              *   )  ( /(   )\ )  ( /(   )\ )  *   )      )\ )  
##   )\        (  ` )  /(  )\()) (()/(  )\()) (()/(` )  /( (   (()/(  
##((((_)(      )\  ( )(_))((_)\   /(_))((_)\   /(_))( )(_)))\   /(_)) 
## )\ _ )\  _ ((_)(_(_())   ((_) (_))    ((_) (_)) (_(_())((_) (_))   
## (_)_\(_)| | | ||_   _|  / _ \ | _ \  / _ \ / __||_   _|| __|| _ \  
##  / _ \  | |_| |  | |   | (_) ||   / | (_) |\__ \  | |  | _| |   /  
## /_/ \_\  \___/   |_|    \___/ |_|_\  \___/ |___/  |_|  |___||_|_\  
## Install:
##
## https://www.powershellgallery.com/packages/MicrosoftStaffHub/1.0.1-alpha
##
## https://www.microsoft.com/en-au/download/details.aspx?id=36824
##
## Run Get-StaffHubMember -TeamId "TEAM_1234" in powershell to find your MEMBERID and set $member
##
## Run the below in powershell 
##
##   Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
##   Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
##
## RESTART your PC
##
## use this then you just pull in the secure string in your script from the encripted txt file, so long as the file is in the same folder as the script.
##
## $sec = ConvertTo-SecureString "Password" -AsPlainText -Force
## $Encrypted = ConvertFrom-SecureString -SecureString $sec -Key (1..16)
## $Encrypted | Set-Content Encrypted.txt
## $Secure2 = Get-Content Encrypted.txt | ConvertTo-SecureString -Key (1..16) 
## 
## $secpasswd = Get-Content Encrypted.txt | ConvertTo-SecureString -Key (1..16) 
## $mycreds = New-Object System.Management.Automation.PSCredential ("username", $secpasswd) 
##
## Use either z-cron or windows scheduler to run every 30 minutes
##
## Set your USERNAME and PASSWORD for staffhub in $secpasswd and $mycreds
##
## Set the below as the launch parameters
##
## -file -ExecutionPolicy ByPass -windowstyle hidden
