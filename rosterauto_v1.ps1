import-module "C:\Program Files\WindowsPowerShell\Modules\MicrosoftStaffHub\1.0.1\Microsoft.OutlookApps.StaffHub.PowershellCmdlets.Common.dll"
import-module "C:\Program Files\WindowsPowerShell\Modules\MicrosoftStaffHub\1.0.1\Microsoft.OutlookApps.StaffHub.PowershellCmdlets.dll"
import-module "C:\Program Files (x86)\Microsoft Office 2013\LyncSDK\Assemblies\Desktop\Microsoft.Lync.Controls.Dll"
import-module "C:\Program Files (x86)\Microsoft Office 2013\LyncSDK\Assemblies\Desktop\Microsoft.Lync.Model.Dll"

$secpasswd = ConvertTo-SecureString "" -AsPlainText -Force 
$mycreds = New-Object System.Management.Automation.PSCredential ("", $secpasswd)
$member = ""

Connect-StaffHub -Credentials $mycreds

$startTime = Get-Date
$endTime = Get-Date
$shift = Get-StaffHubShifts -TeamId "" -StartDateTime $startTime -EndDateTime $endTime -MemberId $member

$shift

$client = [Microsoft.Lync.Model.LyncClient]::GetClient();
$self = $client.Self

##Useful availability codes for use below - 3500 Available, 15500 Away (converted to "Away" in this script by setting activity ID), 6500 Busy, 9500 Do not disturb, 12000 Be Right Back)

if ($shift.Notes -eq 'EDU Phone/Assignment Queue EDU') 
	{
	$availability = 3500
	$message = $shift.Notes
	}
elseif ($shift.Notes -eq 'LIB Phone/Assignment Queue LIB') 
	{
	$availability = 3500
	$message = $shift.Notes
	}
elseif ($shift.Notes -eq 'Lunch') 
	{
	$availability = 12000
	$message = $shift.Notes
	}
else 
	{
	$availability = 6500
	$message = $shift.Notes
	}


$contactInfo = new-object 'System.Collections.Generic.Dictionary[Microsoft.Lync.Model.PublishableContactInformationType, object]'
$contactInfo.Add([Microsoft.Lync.Model.PublishableContactInformationType]::PersonalNote,$message)
$contactInfo.Add([Microsoft.Lync.Model.PublishableContactInformationType]::Availability,$availability)
$ar = $self.BeginPublishContactInformation($contactInfo, $null, $null)
$self.EndPublishContactInformation($ar)

##$wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
##$wshell.Popup($shift.Notes)





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