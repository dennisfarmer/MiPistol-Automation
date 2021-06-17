; https://www.autohotkey.com/docs/KeyList.htm
#NoEnv
#SingleInstance
SendMode Input
SetWorkingDir %A_ScriptDir%

Capslock::Esc
Esc::Capslock

; Run in restart.ahk:
;NumpadIns::Run mipistol.ahk

RWin::Reload

Ctrl & RWin::ExitApp

;NumpadIns::ExitApp
;NumpadIns::DllCall("LockWorkStation")

; The height of the internet explorer search bar
; different from edge
IEHeight = 54
;MSEdgeHeight := ??

; if not fullscreen: blahblahblah
; correct y from top / bottom
topYcorr()
{
    return 0
    ; IE: (Use global variables here) return IEHeight, etc
    ;return 54
    ; Edge
    ;return 103
}

btmYcorr()
{
    return 0
    ; Windows 10 taskbar
    ;return 40
}


ClickBottomSubmit()
{
    GoToBottom()
    Sleep 150
    y := 991 - btmYcorr()
    MouseClick left, 93, %y%
    Sleep 500
    ; click WARN0018 >30 shot warning
    y := 480 - btmYcorr() + topYcorr()
    MouseClick left, 804, %y%
    Sleep 3500
    return
}


GoToTop()
{
    MouseGetPos mX, mY
    y := 66 + topYcorr()
    MouseClick left, 1620, %y%
    Sleep 10
    ; TODO might have to adjust this + GoToBottom
    ; TODO Use ControlFocus instead of clicking
    ;MouseClick, left, 110, 10
    MouseMove mX, mY
    Sleep 10
    Send {Home}
    Sleep 350
    return
}

GoToBottom()
{
    MouseGetPos mX, mY
    y := 66 + topYcorr()
    MouseClick left, 1620, %y%
    Sleep 10
    ;MouseClick, left, 110, 10
    MouseMove mX, mY
    Sleep 10
    Send {End}
    Sleep 350
    return
}

NextRecord()
{
    ControlSend ahk_parent, {Right}, ahk_class Photo_Lightweight_Viewer
    return
}

PrevRecord()
{
    ControlSend ahk_parent, {Left}, ahk_class Photo_Lightweight_Viewer
    return
}

ClickUpload()
{
    GoToBottom()
    y := 500 - btmYcorr()
    MouseMove 344, %y%
    Sleep 300
    ; click upload
    MouseClick left, 344, %y%
    Sleep 1150
    return
}

GoToIndivSearch()
{
    GoToTop()
    y := 181 + topYcorr()
    MouseClick left, 66, %y% ;Welcome
    MouseMove 180, %y%
    Sleep 500 ; Cannot be lower
    MouseClick left, 180, %y% ;Main
    Sleep 100
    y := 238 + topYcorr()
    MouseClick left, 72, %y% ;Enter Pistol
    Sleep 100
    y := 336 + topYcorr()
    MouseClick left, 338, %y% ;CPL
    Sleep 100
    MouseClick left, 70, %y% ;Individual
    Sleep 100
    y := 506 + topYcorr()
    MouseClick left, 90, %y% ;Last Name Field
    y := 629 + topYcorr()
    MouseMove 54, %y% ;Move to first record
    return
}

GoToPistolSearch()
{
    GoToTop()
    y := 181 + topYcorr()
    MouseClick left, 66, %y% ;Welcome
    MouseMove 180, %y%
    Sleep 500 ; Cannot be lower
    MouseClick left, 180, %y% ;Main
    Sleep 100
    y := 238 + topYcorr()
    MouseClick left, 306, %y% ;Search
    Sleep 100
    y := 338 + topYcorr()
    MouseClick left, 608, %y% ;Pistol
    Sleep 100
    y := 506 + topYcorr()
    MouseClick left, 90, %y% ;Serial Number Field
    y := 711 + topYcorr()
    MouseMove 54, %y% ;Move to first record
    return
}

GoToFFLSearch()
{
    GoToTop()
    MouseGetPos mX, mY
    y := 181 + topYcorr()
    MouseClick left, 66, %y% ;Welcome
    Sleep 500 ; Cannot be lower
    MouseClick left, 180, %y% ;Main
    Sleep 100
    y := 238 + topYcorr()
    MouseClick left, 72, %y% ;Enter Pistol
    Sleep 100
    y := 336 + topYcorr()
    MouseClick left, 338, %y% ;CPL
    Sleep 100
    MouseClick left, 609, %y% ;Business/FFL
    Sleep 100
    y := 506 + topYcorr()
    MouseClick left, 210, %y% ;FFL Number Field
    MouseMove mX, mY
    return
}

ClickFirstPistol()
{
    ;Send {NumpadEnter}
    ;Sleep, 500
    y := 711 + topYcorr()
    MouseClick left, 54, %y%
    Sleep 250
    MouseMove 20, %y%
    Sleep 4750
    return
}

UploadSalesRecord()
{
    GoToBottom()
    y := 584 - btmYcorr()
    MouseMove 279, %y%
    Sleep 300
    MouseClick left, 279, %y%
    Sleep 750
    GoToBottom()
    y := 575 - btmYcorr()
    MouseMove 922, %y%
    Sleep 300
    MouseClick left, 922, %y%
    Sleep 400
    WinGetTitle filename, ahk_class Photo_Lightweight_Viewer
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
        Loop 7
        {
            Send {Tab}
            Sleep 200
        }
    }
    else
    {
        Send {Alt down}{F4}{Alt up}
        Sleep 200
        MouseClick left, 922, %y%
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
    ; Preselect "Overall Length" field since it's forgotten a lot
    ; of the time
    Sleep 200
    y := 650 + topYcorr()
    MouseClick left, 953, %y%
    ;TODO: select text with shift tab + tab and copy to clipboard
    ; enter numlock mode on if field is empty
    ;Send {End}{Shift down}{Home}{Shift up}
    return
}

SelectRecordType()
{
    GoToBottom()
    y := 572 - btmYcorr()
    MouseMove 390, %y%
    Sleep 200
    MouseClick left, 390, %y%
    Loop 4
    {
        Sleep, 150
        Send r
    }
    Sleep 300
    Send {Enter}
    Sleep 200
    y := 578 - btmYcorr()
    MouseClick left, 442, %y%
    Sleep 100
    return
}

SubmitSalesRecord()
{
    ClickBottomSubmit()
    Send {NumLock}
    ClickUpload()
    return
}

SC029 & 1::
SetNumLockState On
GoToIndivSearch()
return

SC029 & 2::
SetNumLockState On
GoToPistolSearch()
return

SC029 & 3::
SetNumLockState On
GoToFFLSearch()
return

NumpadEnd::
ClickUpload()
NextRecord()
SetNumLockState On
GoToPistolSearch()
return

;TODO
NumpadDown::
Run msedge.exe
;ControlFocus ahk_exe msedge.exe
WinWait Microsoft Edge,, 0.5
;WinWaitActive ahk_exe msedge.exe
;Send {Ctrl down}t{Ctrl up}
Send http://hcs551chrspw902.mspad.state.mi.us:9080/navigator/{Enter}
Sleep 200
Send {Ctrl down}l{Ctrl up}
Sleep 200
Send {Space}Selected Handgun Detail{Home}genitron{Space}
;Send {LWin down}{Right}{LWin up}
SetNumLockState On
SetCapsLockState On
return

NumpadPgDn::
SubmitSalesRecord()
NextRecord()
GoToIndivSearch()
return

NumpadDel::
if (!WinActive(,"PISTOL - Work - Microsoft Edge")) {
    ; currently runs when mipistol is active, TODO
    ; 6/16: should be fixed, see help page
    
    Send {Ctrl down}w{Ctrl up}

}
ControlFocus,, ahk_exe msedge.exe, "PISTOL - Work - Microsoft Edge"
SetNumLockState On
SetCapsLockState Off
return

NumpadEnter::
SetNumLockState Off
Send {Enter}
return

NumpadLeft::
UploadSalesRecord()
return

NumpadRight::
SubmitSalesRecord()
NextRecord()
GoToPistolSearch()
return

NumpadHome::Send /

;NumpadUp::ClearField()
NumpadUp::
ClickUpload()
;ClickBottomSubmit()
GoToTop()
Sleep 150
y := 254 + topYcorr()
MouseClick left, 432, %y%
Send {Numlock}
Sleep 1000
y := 589 + topYcorr()
MouseClick left, 206, %y%
Sleep 100
Send {End}{Shift down}{Home}{Shift Up}
return

NumpadPgUp::
ClickFirstPistol()
UploadSalesRecord()
SetNumLockState Off
return

NumpadDiv::PrevRecord()

NumpadMult::NextRecord()

NumpadSub::+Tab

NumpadAdd::Tab

; TODO Use backtick commands to click on first user in list, click enter pistol,
; click enter individual using data from fields to fill the new user fields, etc..

; Backtick+Q goes to first entry in list of pistols
;SC029 & Q::
;MouseClick, left, 265, 745
;sleep, 10
;MouseClick, left, 265, 750 ;Go to pistols menu
;sleep, 400
;MouseClick, left, 73, 880 ;Move to first record
;return

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
