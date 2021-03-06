<!+`;::CatalystControlCenterReactivateControl()

/**
  @brief Activates day-time mode for monitors.
  */
<!+q::
{
  if (1 == CatalystControlCenterActivate())
  {
    return
  }

  Send("{Tab 12}{Enter}") ; Expand "My Digit Flat-Panels".
  Send("{Tab 2}{Enter}")  ; Open "Display Color (Digital Flat-Panel)".

  Send("{Tab 10}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Enter}")         ; Select Monitor 1 (side monitor).
  Sleep(500)              ; Wait for monitor select menu to disappear.
  Send("{Tab 16}{Enter}") ; Select "Defaults".

  Send("+{Tab 16}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Tab 3}{Enter}")   ; Select Monitor 2 (side monitor).
  Sleep(1000)              ; Wait for monitor select menu to disappear.
  Send("{Tab 16}{Enter}") ; Select "Defaults".

  Send("+{Tab 16}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Tab 4}{Enter}")   ; Select Monitor 3 (center monitor).
  Sleep(1000)              ; Wait for monitor select menu to disappear.
  Send("{Tab 16}{Enter}") ; Select "Defaults".

  Send("{Right 2}{Enter}") ; Apply changes.
  Sleep(1000) ; Wait for changes to apply.

  WinClose()

  return
}

/**
  @brief Activates night-time mode for monitors.
  */
<!+j::
{
  ; Temperature has range from 4000 to 6500.
  center_temp := 4500
  sides_temp := 4000

  ; Brightness has range from -100 to 0.
  center_brightness := -25
  sides_brightness := -25

  sides_temp_num_lefts := (6500 - sides_temp) / 100
  center_temp_num_lefts := (6500 - center_temp) / 100

  sides_bright_num_lefts := sides_brightness * -1
  center_bright_num_lefts := center_brightness * -1

  if (1 == CatalystControlCenterActivate())
  {
    return
  }

  Send("{Tab 12}{Enter}") ; Expand "My Digit Flat-Panels".
  Send("{Tab 2}{Enter}")  ; Open "Display Color (Digital Flat-Panel)".

  Send("{Tab 10}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Enter}")         ; Select Monitor 1 (side monitor).
  Sleep(500)              ; Wait for monitor select menu to disappear.
  Send("{Tab 9}{Left " sides_temp_num_lefts "}")    ; Lower Temperature.
  Send("{Tab 3}{Left " sides_bright_num_lefts  "}") ; Lower Brightness.

  Send("+{Tab 12}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Tab 3}{Enter}")   ; Select Monitor 2 (side monitor).
  Sleep(1000)              ; Wait for monitor select menu to disappear.
  Send("{Tab 9}{Left " sides_temp_num_lefts "}")    ; Lower Temperature.
  Send("{Tab 3}{Left " sides_bright_num_lefts  "}") ; Lower Brightness.

  Send("+{Tab 12}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Tab 4}{Enter}")   ; Select Monitor 3 (center monitor).
  Sleep(1000)              ; Wait for monitor select menu to disappear.
  Send("{Tab 9}{Left " center_temp_num_lefts "}")    ; Lower Temperature.
  Send("{Tab 3}{Left " center_bright_num_lefts  "}") ; Lower Brightness.

  Send("{Tab 4}{Right 2}{Enter}") ; Apply changes.
  Sleep(1000) ; Wait for changes to apply.

  WinClose()

  return
}


/**
  @brief Turn off the display in a specified time in minutes.
  */
<!s::
{
  minutes := InputBox("Monitor Shutoff", "", "", 150, 100)
  milliseconds := minutes * 60000

  ; Set the priority low to allow script to still function.
  ThreadPriority(-1000)
  Sleep(milliseconds)
  SendMessage(0x112, 0xF170, 2, "", "Program Manager")
  return
}
