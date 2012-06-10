mklink /H %HOMEDRIVE%\%HOMEPATH%\_gvimrc %CD%\gvimrc
mklink /H %HOMEDRIVE%\%HOMEPATH%\_vimrc %CD%\vimrc
copy gvimrc.local %HOMEDRIVE%\%HOMEPATH%\_gvimrc.local
copy vimrc.local %HOMEDRIVE%\%HOMEPATH%\_vimrc.local
