^Space::
{
    /* SETTING */
    ; Set to true to force Chinese mode when switching to XP Cangjie keyboard, false otherwise
    static ForceNativeMode := true

    ; Get handle of the current active window
    hwnd := WinExist("A")

    ; Use DllCall's GetWindowThreadProcessId function to retrieve Thread ID (TID)
    threadID := DllCall("GetWindowThreadProcessId", "Ptr", hwnd, "UInt", 0, "UInt")

    ; Get the current langID
    hkl := DllCall("GetKeyboardLayout", "UInt", threadID, "Ptr")
    langID := hkl & 0xFFFF

    /*
    Language ID (langID) Reference:
    - 0x0404 (1028): Chinese (Taiwan)
    - 0x0C04 (3076): Chinese (Hong Kong)
    - 0x0411 (1041): Japanese
    */

   ; Switch to English Keyboard from Chinese/Japanese keyboard
    if (langID = 1028 || langID = 3076 || langID = 1041) {
        /*
        Message Identifier (IME Command):
        - 0x50 (WM_INPUTLANGCHANGEREQUEST): Switch keyboard layouts

        Keyboard
        English (US) keyboard ID: 0x04090409
        */
        PostMessage(0x50, 0, 0x04090409, , "ahk_id " hwnd)
    }

    ; Change to XP Cangjie keyboard
    else {
        /* XP Cangjie HKL: 0xE0020404 
        In AHK2, numbers are in 64-bit. We use (<< 32 >> 32) to force this 
        value into a 32-bit Signed Integer (-536738812), which is the 
        exact format Windows expects for this specific keyboard layout.
        */
        PostMessage(0x50, 0, (0xE0020404 << 32 >> 32), , "ahk_id " hwnd)
        
        ; Force IME into native mode (Non-Alphanumeric  mode)
        if (ForceNativeMode) {
            Sleep(50) 
            DetectHiddenWindows(true)
            
            ; Get the default IME window for the active window
            defaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", "Ptr", hwnd, "Ptr")
            
            ; Test if the hidden IME window is found and available
            if (defaultIMEWnd) {
            /*
            Message Identifier (IME Command):
            - 0x0283 (WM_IME_CONTROL): Message Identifier used for IME instructions
            - 0x0002 (IMC_SETCONVERSIONMODE):IME Command to set conversion mode
            CONVERSIONMODE is a bitmask where:
            - 0 = Alphanumeric Mode (Pure English / Direct Input)
            - 1 = Native Mode (IME Active / Chinese / Japanese / Korean)

            SendMessage(Msg, wParam, lParam, Control, WinTitle)
            */
                SendMessage(0x0283, 0x0002, 1, , "ahk_id " defaultIMEWnd)
            }
            DetectHiddenWindows(false)
        }
    }
}