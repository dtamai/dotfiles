dotfiles
========
Some dotfiles.

## Vim
TODO: brief description (the local file)

# Installation

### Windows
#### Requirements
* user must have privilege to create symbolic links  
> In Windows 7:  
> Control Panel
> \> Security  
> \- \> Administrative Tools  
> \- - \> Security Settings  
> \- - - \> Local Policies  
> \- - - - \> User Rights Assignment  
> \- - - - - \> Create symbolic links  
> \- - - - - - \> add user  

* the files and the user folder must be in the same drive (it's not possible to create hard links between drives)  
> If the user folder is "C:\Users\\_username_" than the files must be in "C:\\_some folder_"

Then run __install.bat__ to create the links
