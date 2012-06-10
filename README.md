# dotfiles
Some dotfiles.

## Vim ##
The local files (.local) are just copied to their places, it's not important that they are versioned.

## Installation ##

### Windows ###
__install.bat__

#### Requirements ####
* user must have privilege to create symbolic links (if non-admin)  
> In Windows 7:  
> Control Panel
> \> Security  
> \- \> Administrative Tools  
> \- - \> Security Settings  
> \- - - \> Local Policies  
> \- - - - \> User Rights Assignment  
> \- - - - - \> Create symbolic links  
> \- - - - - - \> add user  

* the files and the user folder must be in the same drive (it's not possible to create hard links between drives; it works with soft links, but opening the link for writing will create a new file and the link will be overwritten i.e. the file will be out of version control)
> If the user folder is "C:\Users\\_username_" than the files must be in "C:\\_some folder_"

### Linux ###
__install.sh__

#### Requirements ####
--

