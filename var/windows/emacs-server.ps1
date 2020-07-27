# declare where to delete the server file before relaunching.
$script:emacsserverfile = $ENV:UserProfile + "\.emacs.d\server\server"

# stop any active emacs process
Stop-Process -Name "emacs" -ErrorAction SilentlyContinue | Out-Null

# delete server file
Remove-Item $emacsserverfile -Force -ErrorAction SilentlyContinue | Out-Null

# start emacs server
Start-Process -FilePath runemacs.exe -WorkingDirectory $ENV:UserProfile -ArgumentList '--daemon'
