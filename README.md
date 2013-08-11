# dotfiles
Some dotfiles.

## Vim
The local files (.local) are just copied to their places, it's not important that they are versioned.

## Installation

### Windows
    install.bat

#### Requirements
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

* the files and the user folder must be in the same drive

It's not possible to create hard links between drives; it works with soft links, but opening the link for writing will create a new file and the link will be overwritten.


### Linux
    ./install.sh

#### Requirements
--

