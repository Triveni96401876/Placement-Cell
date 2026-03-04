@echo off
setlocal enabledelayedexpansion
pushd c:\placementcell\admin
for /f "delims=" %%f in ('dir /b') do (
    set "fname=%%f"
    set "clean=!fname!"
    :removetrail
    if "!clean:~-1!"==" " (
        set "clean=!clean:~0,-1!"
        goto remotrail
    )
    if not "!fname!"=="!clean!" (
        echo Renaming ["!fname!"] to ["!clean!"]
        ren "!fname!" "!clean!"
    )
)
popd
echo Admin done.
