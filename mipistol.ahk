; https://www.autohotkey.com/docs/KeyList.htm
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

Capslock::Esc
Esc::Capslock

NumpadAdd::Tab
NumpadSub::+Tab
NumpadMult::P

;NumpadIns::ExitApp
NumpadIns::DllCall("LockWorkStation")

ClickBottomSubmit()
{
    GoToBottom()
    MouseClick, left, 93, 991
    Sleep, 500
    ; click WARN0018 >30 shot warning
    MouseClick, left, 808,504
    Sleep, 3500
    return
}


GoToTop()
{
    MouseGetPos, mX, mY
    MouseClick, left, 1620,120
    Sleep, 10
    MouseClick, left, 110, 10
    MouseMove, mX, mY
    Sleep, 10
    Send {Home}
    Sleep, 350
    return
}

GoToBottom()
{
    MouseGetPos, mX, mY
    MouseClick, left, 1620,120
    Sleep, 10
    MouseClick, left, 110, 10
    MouseMove, mX, mY
    Sleep, 10
    Send {End}
    Sleep, 350
    return
}

NextRecord()
{
    ControlSend, ahk_parent, {Right}, ahk_class Photo_Lightweight_Viewer
    return
}

PrevRecord()
{
    ControlSend, ahk_parent, {Left}, ahk_class Photo_Lightweight_Viewer
    return
}

ClearField()
{
    MouseGetPos, mX, mY
    MouseClick, left, 300, 573
    MouseMove, mX, mY
    Send {Shift down}{Tab}{Shift up}{Tab}
    Send {Backspace}
    return
}

ClickUpload()
{
    GoToBottom()
    MouseMove, 344, 500
    Sleep, 300
    ; click upload
    MouseClick, left, 344, 500
    Sleep, 1150
    return
}

;NumpadUp::ClearField()
NumpadUp::
ClickUpload()
ClickBottomSubmit()
GoToTop()
Sleep 150
MouseClick left, 432, 308
Send {Numlock}
Sleep 1000
MouseClick left, 206, 643
Sleep 100
Send {End}{Shift down}{Home}{Shift Up}
return



GoToIndivSearch()
{
    GoToTop()
    MouseClick, left, 66, 235 ;Welcome
    MouseMove, 180, 235
    Sleep, 500 ; Cannot be lower
    MouseClick, left, 180, 235 ;Main
    Sleep, 100
    MouseClick, left, 72, 292 ;Enter Pistol
    Sleep, 100
    MouseClick, left, 338, 390 ;CPL
    Sleep, 100
    MouseClick, left, 70, 390 ;Individual
    Sleep, 100
    MouseClick, left, 90, 560 ;Last Name Field
    MouseMove 54, 683 ;Move to first record
    return
}

GoToPistolSearch()
{
    GoToTop()
    Sleep, 100
    MouseClick, left, 66, 235 ;Welcome
    ;MouseMove, 180, 235
    Sleep, 500 ; Cannot be lower
    MouseClick, left, 180, 235 ;Main
    Sleep, 100
    MouseClick, left, 306, 292 ;Search
    Sleep, 100
    MouseClick, left, 608, 392 ;Pistol
    Sleep, 100
    MouseClick, left, 90, 560 ;Serial Number Field
    MouseMove 54, 765 ;Move to first record
    return
}

GoToFFLSearch()
{
    GoToTop()
    MouseGetPos, mX, mY
    MouseClick, left, 66, 235 ;Welcome
    Sleep, 500 ; Cannot be lower
    MouseClick, left, 180, 235 ;Main
    Sleep, 100
    MouseClick, left, 72, 292 ;Enter Pistol
    Sleep, 100
    MouseClick, left, 338, 390 ;CPL
    Sleep, 100
    MouseClick, left, 609, 390 ;Business/FFL
    Sleep, 100
    MouseClick, left, 210, 560 ;FFL Number Field
    MouseMove, mX, mY
    return
}

ClickFirstPistol()
{
    ;Send {NumpadEnter}
    ;Sleep, 500
    MouseClick, left, 54, 765
    Sleep, 5000
    return
}

UploadSalesRecord()
{
    GoToBottom()
    MouseMove, 279, 584
    Sleep, 300
    MouseClick, left, 279, 584
    Sleep, 750
    GoToBottom()
    MouseMove, 922, 575
    Sleep, 300
    MouseClick, left, 922, 575
    Sleep, 400
    WinGetTitle, filename, ahk_class Photo_Lightweight_Viewer
    filename := StrReplace(filename, " - Windows Photo Viewer", "")
    ;TODO modify for other filetypes (regex catch until underscore)
    ; RI-060_00XX-XXXXXX.tif
    batchnumber := SubStr(filename, 13, 6)
    Send {Alt down}{d}{Alt up}
    Sleep 50
    cbcontents = %clipboard%
    Send {Ctrl down}{c}{Ctrl up}
    Sleep 50
    path := "X:\MiPistol\RI-060\Dennis\" batchnumber "-Farmer"
    if (path != clipboard)
    {
        Send %path%{Enter}
        Sleep 200
        Send {Tab}
        Sleep 200
        Send {Tab}
        Sleep 200
        Send {Tab}
        Sleep 200
        Send {Tab}
        Sleep 200
        Send {Tab}
        Sleep 200
        Send {Tab}
        Sleep 200
        Send {Tab}
        Sleep 200
    }
    else
    {
        Send {Alt down}{F4}{Alt up}
        Sleep 200
        MouseClick, left, 922, 575
        Sleep 250
    }
    Try clipboard := cbcontents
    Sleep 200
    Send %filename%
    Sleep 200
    Send {Enter}
    Sleep 300
    SelectRecordType()
    GoToTop()
    return
}

SelectRecordType()
{
    GoToBottom()
    MouseMove, 390, 572
    Sleep, 200
    MouseClick, left, 390, 572
    Sleep, 150
    Send r
    Sleep, 150
    Send r
    Sleep, 150
    Send r
    Sleep, 150
    Send r
    Sleep, 300
    Send {Enter}
    Sleep, 200
    MouseClick, left, 442, 578
    Sleep, 100
    return
}

SubmitSalesRecord()
{
    ClickUpload()
    Send {NumLock}
    ClickBottomSubmit()
    return
}

SC029 & 1::
GoToIndivSearch()
return

SC029 & 2::
GoToPistolSearch()
return

SC029 & 3::
GoToFFLSearch()
return

NumpadEnd::
ClickFirstPistol()
UploadSalesRecord()
return

;TODO
NumpadDown::
Run, msedge.exe
;ControlFocus ahk_exe msedge.exe
WinWait, Microsoft Edge,, 0.5
;WinWaitActive ahk_exe msedge.exe
;Send {Ctrl down}t{Ctrl up}
Send {Space}Selected Handgun Detail{Home}genitron{Space}
Send {LWin down}{Right}{LWin up}
SetNumLockState On
return

NumpadDel::
if (!WinActive("PISTOL - Work - Microsoft Edge")) {
    ; currently runs when mipistol is active, TODO
    Send {Ctrl down}w{Ctrl up}

}
ControlFocus, ahk_exe msedge.exe, PISTOL - Work - Microsoft Edge
SetNumLockState On
return

NumpadPgUp::NextRecord()
NumpadHome::PrevRecord()

NumpadPgDn::
SubmitSalesRecord()
NextRecord()
GoToIndivSearch()
return

NumpadLeft::
UploadSalesRecord()
return

NumpadRight::
SubmitSalesRecord()
NextRecord()
GoToPistolSearch()
return

; TODO Use backtick commands to click on first user in list, click enter pistol,
; click enter individual using data from fields to fill the new user fields, etc..

; Backtick+Q goes to first entry in list of pistols
SC029 & Q::
MouseClick, left, 265, 745
sleep, 10
MouseClick, left, 265, 750 ;Go to pistols menu
sleep, 400
MouseClick, left, 73, 880 ;Move to first record
return

Control & Backspace::
MouseGetPos, mX, mY
MouseClick, left, 1650, 920
MouseMove, mX, mY
sleep, 1
Send {Backspace}
return

;TODO send scanned batches email to whole team
;To:
; (gitignore the file with michigan.gov emails)

;tab tab
; send Entry{Space}Batches
; I have scanned the following batch numbers for myself:

;RI-060:
;----------
