# WinXP-Cangjie-IME-Enhancer_XP-8-10

**Restores the classic Windows XP Ctrl+Space input switching logic to modern Windows (8/10) and adds the legacy XP Cangjie experience with a modern LShift conversion mode toggle.**

## Background
Starting from **Windows 7**, Microsoft performed an overhaul of the Cangjie keyboard, one of the major Traditional Chinese input methods used in Hong Kong. However, the Windows 7 Cangjie input introduced serveral disadvantages for users:
- Loss of audio cues: No beep sound is played when a character needs to be picked from multiple possible candidates
- Changed Spacebar Logic: The `Space` key no longer inputs a space character when the related-vocabulary page appers. Instead, `Space` now moves to the the next related-vocab page. Users are forced to press `Esc` to close the vocab list before they can input a space, which severely breaks typing flow.
- Intrusive Auto-language-Detection: The "Auto-detection" logic often erroneously switches the IME from Cangjie into alphabetic mode (e.g., when clicking the browser address bar), requiring manual correction.

Starting from **Windows 8**, these problems persisted, and Microsoft further changed the default keyboard switching shortcut from `Ctrl + Space` to `Win + Space`. This created a massive inconvenience for users with decades of muscle memory dating back to **Windows 95**. This project aims to restoring the legacy behaviour through AutoHotKey.

## Script Summary

| Feature Section | Primary Script File |
| :--- | :--- |
| **1. Restoration of Legacy `Ctrl + Space` Logic** | `CtrlSpace_Toggle.ahk` |
| **2. Initial Auto-Native Mode** | `CtrlSpace_Toggle.ahk` |
| **3. Modern `LShift` Conversion Toggle** | `LShift_Toggle.ahk` |

---

## Prerequisite

1.  **XP Cangjie Files:** The legacy Windows XP Cangjie IME files must be manually installed and registered on your system (not included in Windows 8/10 by default).
2.  **Multiple Keyboards:** You should have multiple keyboard layouts installed (e.g., English, Chinese (Taiwan), and optionally others like Japanese or Korean).

> [!NOTE]
> **Legacy vs. Modern Behavior:** In original Windows XP, the `Ctrl + Space` shortcut was a global toggle between English and the active Chinese IME even if you only have the Chinese (Taiwan) language activated. In morden Windows, you should have multiple keyboard layouts installed before using this script.
> 
> **UWP Compatibility:** The Windows XP Cangjie engine is **not compatible** with modern Windows UWP (Universal Windows Platform) apps. 
> - *Developer's Note:* This script is optimised for the vast majority of "Classic" Win32 desktop software where high-speed typing and legacy behavior are most critical.

## Features & Enhancements

### 1. Restoration of Legacy `Ctrl + Space` Logic
This script restores the `Ctrl + Space` hotkey to function as a direct toggle between your primary English layout and the Classic XP Cangjie layout.

- **Multi-Keyboard Handling:** For users with more than two layouts (e.g., English (US), Chinese (Taiwan), and Japanese), the script is designed to always "toggle" back to English, or from English to XP Cangjie. This prevents getting "stuck" in a third language during a quick switch.

- **Switching to thrid or more Keyboards:** To access your other layouts (like Japanese or Korean), you can still use the standard `Win + Space` shortcut as introduced in Windows 8+.

### 2. Initial Auto-Native Mode
There are a total of four input modes in the XP Cangjie input.

| Mode | Type | Width | Indicator |
| :--- | :--- | :--- | :--- |
| **Mode 1** | Native (Chinese) | Half-width | ![native-half](./img/native-half.png) |
| **Mode 2** | Native (Chinese) | Full-width | ![native-full](./img/native-full.png) |
| **Mode 3** | Alphanumeric (English) | Half-width | ![alphanumeric-half](./img/alphanumeric-half.png) |
| **Mode 4** | Alphanumeric (English) | Full-width | ![alphanumeric-full](./img/alphanumeric-full.png) |

When switching to Cangjie, the script automatically forces the IME into Mode 1 (Native mode, half-width) upon activation. This eliminates the "double-action" frustration where you have already switched keyboard layouts but still have to press `Shift` again to stop typing in English.

Additionally, this feature prevents issues with certain pieces of software that tend to force the IME back into alphabetic mode by default. With this script, your XP Cangjie layout always stays in "Native Mode" as intended when it starts.

### 3. Modern `LShift` Conversion Toggle
While the original Windows XP Cangjie IME relied on `Ctrl + Space` for layout switching, Windows 7 introduced the use of the `Shift` key to toggle between Native and Alphanumeric modes within a single click.

This project brings the convenience of the Windows 7+ style `LShift` toggle to switch between **Alphebetic-half** and **Native-half** instantly when you need to quickly type a English characters or symbols in the middle of some Chinese content.

- Tap `LShift` to Toggle: A quick press and release of the `LShift` key toggles the input mode.
- Hold to Type: The script preserves the standard ability to hold down the `Shift` key to type capital letters or symbols without triggering a mode switch.


## Script Optimization & Customization

These scripts are pre-optimised for a specific regional configuration. If your setup differs, you **must** modify the scripts as described below:

### 1. Hardcoded Keyboard Layout ID (HKL)
The scripts are currently optimised for the **Chinese (Taiwan) Locale** using the legacy XP Cangjie IME. 
* **Default Target ID:** `0xE0020404` 

### 2. Manual Modification
If you are using a different regional version (e.g., Hong Kong `0x0C04`) or a different IME (e.g., Quick), you may need to:
1.  Identify your specific Keyboard Layout ID (HKL) / Language ID (langID).
2.  Open the `.ahk` files in a text editor.
3.  Replace `0xE0020404` with your HKL ID and langID.
