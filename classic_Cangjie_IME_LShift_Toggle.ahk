~LShift Up:: {
    ; A_PriorKey to ensure that IME only toggles if Shift was pressed alone
    if (A_PriorKey != "LShift") {
        return
    }

    ; Get handle of the current active window
    hwnd := WinExist("A")
    DetectHiddenWindows True
    
    ; Use DllCall's ImmGetDefaultIMEWnd function to retrieve IME handle
    defaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", "Ptr", hwnd, "Ptr")
    
    ; Test if the hidden IME window is found and available
    if (defaultIMEWnd) {
        /*
        Message Identifier (IME Command):
        - 0x0283 (WM_IME_CONTROL): Message Identifier used for IME instructions
        - 0x0001 (IMC_GETCONVERSIONMODE): IME Command to retrieve current input state (CONVERSIONMODE)
        - 0x0002 (IMC_SETCONVERSIONMODE):IME Command to set conversion mode
        CONVERSIONMODE is a bitmask where:
        - 0 = Alphanumeric Mode (Pure English / Direct Input)
        - 1 = Native Mode (IME Active / Chinese / Japanese / Korean)

        SendMessage(Msg, wParam, lParam, Control, WinTitle)
        */
        currentMode := SendMessage(0x0283, 0x0001, 0, , "ahk_id " defaultIMEWnd)
        
        ; Toggle between Alphanumeric and Native Mode
        newMode := (currentMode == 1) ? 0 : 1
        SendMessage(0x0283, 0x0002, newMode, , "ahk_id " defaultIMEWnd)
    }
    
    DetectHiddenWindows False
}