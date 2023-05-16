$global:ShellProxy = new-object -com Shell.Application
$shell = $global:ShellProxy
# 17 (0x11) = ssfDRIVES from the ShellSpecialFolderConstants (https://msdn.microsoft.com/en-us/library/windows/desktop/bb774096(v=vs.85).aspx)
# => "My Computer" — the virtual folder that contains everything on the local computer: storage devices, printers, and Control Panel.
# This folder can also contain mapped network drives.
$shellItem = $shell.NameSpace(17).self
$phone = $shellItem.GetFolder.items() | where { $_.name -match 'Apple' }
$phone.GetFolder.Items()
$folder = $phone.GetFolder.Items() 
$folder

Get-ChildItem -Path 'mtp://Apple iPhone/Internal Storage/DCIM'

Get-PSDrive


