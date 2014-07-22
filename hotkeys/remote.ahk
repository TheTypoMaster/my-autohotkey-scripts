/**
  @brief Hotkeys for the F-Dolphin Air Mouse.
  */


/**
  @brief Setup XBMC as full screen and enable remote mode.
  @notes remote's home button
  */
#e::
{
  if (!WinExist("ahk_class XBMC")) {
    Run("C:\Program Files (x86)\XBMC\XBMC.exe")
  }

  WinWait("ahk_class XBMC")
  WinActivate("ahk_class XBMC")
  WinWaitActive("ahk_class XBMC", "", 5)
  WinMove("ahk_class XBMC", "", 0, 0)

  if (!IsFullScreen("ahk_class XBMC")) {
    Send("\")
  }

  remote_mode_enabled := true
  Speak("remote mode enabled")
  return
}

#If WinActive("ahk_class XBMC")
{
  /**
    @brief XBMC fullscreen toggle key also used to disable remote mode.
    */
  ~$\::
  {
    if (remote_mode_enabled) {
      remote_mode_enabled := false
      Speak("remote mode disabled")
    }
    return
  }

  /**
    @brief Remote Mode Enabled: set timer to sleep computer
           Remote Mode Disabled: enable remote mode
    @notes remote home button
    */
  #e::
  {
    if (remote_mode_enabled) {
      Gui, Font, s64, Verdana
      Gui, Add, Text,, Sleep
      Gui, Font, s128, Verdana
      Gui, Margin, 64, 64
      Gui, Add, Edit, Number W420
      Gui, Add, UpDown, vminutes Range0-180, 30
      Gui, Font, s64, Verdana
      Gui, Add, Button, W420 Default, OK
      Gui, Add, Button, W420, Cancel
      Gui, Show
      return

      ButtonOK:
      {
        Gui, Submit
        Speak("going to sleep in " . minutes . " minutes")

        delayTime := minutes * 60000
        Thread, Priority, -1000  ; sets priority low to allow script to still function
        Sleep, %delayTime%
        DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

        Gui, Destroy
        return
      }

      ButtonCancel:
      {
        Gui, Submit
        Gui, Destroy
        return
      }
    }
    else {
      WinMove("ahk_class XBMC", "", 0, 0)
      if (!IsFullScreen("ahk_class XBMC")) {
        Send("\")
      }
      remote_mode_enabled := true
      Speak("remote mode enabled")
      return
    }
  }

  /**
    @brief Remote Mode Enabled: set timer to black out screen
           Remote Mode Disabled: space
    @notes remote handmenu button
    */
  $Space::
  {
    if (remote_mode_enabled) {
      Gui, 2:Default
      Gui, Font, s64, Verdana
      Gui, Add, Text,, Monitor
      Gui, Font, s128, Verdana
      Gui, Margin, 64, 64
      Gui, Add, Edit, Number W420
      Gui, Add, UpDown, vminutes Range0-180, 30
      Gui, Font, s64, Verdana
      Gui, Add, Button, W420 Default, OK
      Gui, Add, Button, W420, Cancel
      Gui, Show
      return

      2ButtonOK:
      {
        Gui, Submit
        Speak("turning monitor off in " . minutes . " minutes")

        delayTime := minutes * 60000
        Thread, Priority, -1000  ; sets priority low to allow script to still function
        Sleep, %delayTime%

        ; TODO: replace sleep with show black screen since cannot screensaver during playback
        ;Gui, Color, black
        ;Gui +AlwayOnTop
        ;Gui -Caption
        ;Gui, Show, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%
          ;return

        SendMessage, 0x112, 0xF170, 2,, Program Manager   ; 0x112 is WM_SYSCOMMAND, 0xF170 is SC_MONITORPOWER.

        Gui, Destroy
        return
      }

      2ButtonCancel:
      {
        Gui, Submit
        Gui, Destroy
        return
      }
    }
    else {
      Send("{Space}")
    }
  }

  /**
    @brief Remote Mode Enabled:  backspace/back
           Remote Mode Disabled: right click
    @notes remote back button
    */
  RButton::
  {
    if (remote_mode_enabled) {
      Send("{Backspace}")
    }
    else {
      Send("{RButton}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  hide full-screen menu
           Remote Mode Disabled: escape
    @notes remote voice button
    */
  Escape::
  {
    if (remote_mode_enabled) {
      Send {Tab}
    }
    else {
      Send("{Escape}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  restart autohotkey (to stop countdowns)
           Remote Mode Disabled: exit
    @notes remote voice button (hold)
    */
  !F4::
  {
    if (remote_mode_enabled) {
      Speak("restarting auto hot key")
      Reload()
    }
    else {
      Send("!{F4}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  queue file
           Remote Mode Disabled: mute volume
    @notes remote mute button
    */
  Volume_Mute::
  {
    if (remote_mode_enabled) {
      Send("q")
    }
    else {
      Send("{Volume_Mute}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  space (play/pause)
           Remote Mode Disabled: media_play_pause
    @notes remote play/pause button
           Remapped like this not to accidently play music.
    */
  Media_Play_pause::
  {
    if (remote_mode_enabled) {
      Send("{Space}")
    }
    else {
      Send("{Media_Play_pause}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  left (for easier rewind)
           Remote Mode Disabled: previous media
    @notes remote previous media button
    */
  Media_Prev::
  {
    if (remote_mode_enabled) {
      Send("{Left}")
    }
    else {
      Send("{Media_Prev}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  right (for easier fast forward)
           Remote Mode Disabled: next media
    @notes remote next media button
    */
  Media_Next::
  {
    if (remote_mode_enabled) {
      Send("{Right}")
    }
    else {
      Send("{Media_Next}")
    }
    return
  }
}
#If

