#if os(Windows)
import WinSDK

func prepareTerminal() {
    SetConsoleOutputCP(UINT(65001))
    let handle = GetStdHandle(STD_OUTPUT_HANDLE)
    var mode: DWORD = 0
    if GetConsoleMode(handle, &mode) {
        // 0x0004 = ENABLE_VIRTUAL_TERMINAL_PROCESSING (cores ANSI)
        _ = SetConsoleMode(handle, mode | 0x0004)
    }
}
#else
func prepareTerminal() {}
#endif