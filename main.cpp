#include <windows.h>
#include <windowsx.h>
#include <dwmapi.h>
#include <shlwapi.h>
#include <shellapi.h>

#include <cmath>
#include <string>
#include <vector>

#pragma comment(lib, "user32.lib")
#pragma comment(lib, "gdi32.lib")
#pragma comment(lib, "dwmapi.lib")
#pragma comment(lib, "shlwapi.lib")
#pragma comment(lib, "shell32.lib")

namespace {

constexpr wchar_t kBatName[] = L"wasd tweak.bat";

constexpr int kOkBtnId = 1001;
constexpr int kLinkId = 1002;
constexpr wchar_t kWindowClass[] = L"WasdTweakFinishedGate";
constexpr wchar_t kGithubUrl[] = L"https://github.com/Theodor1151/wasd-performance-tweaker-for-gta";
constexpr UINT kSpinTimerId = 1;
constexpr UINT kRevealTimerId = 2;
constexpr UINT kSpinIntervalMs = 16;
constexpr UINT kLoadingDurationMs = 2000;
constexpr int kSpinnerRadius = 22;
constexpr int kWindowW = 400;
constexpr int kWindowH = 164;

constexpr COLORREF kDarkBg = RGB(18, 18, 22);
constexpr COLORREF kDarkText = RGB(230, 230, 235);
constexpr COLORREF kDarkBtn = RGB(45, 48, 56);
constexpr COLORREF kDarkBtnBorder = RGB(90, 95, 108);
constexpr COLORREF kSpinnerColor = RGB(120, 170, 255);

struct GateState {
    bool show_finished = false;
    int spin_deg = 0;
    HWND label_hwnd = nullptr;
    HWND link_hwnd = nullptr;
    HWND ok_btn = nullptr;
    HBRUSH bg_brush = nullptr;
    HFONT link_font = nullptr;
};

std::wstring module_directory() {
    wchar_t path[MAX_PATH] = {};
    if (GetModuleFileNameW(nullptr, path, MAX_PATH) == 0) {
        return L".";
    }
    PathRemoveFileSpecW(path);
    return path;
}

std::wstring bat_path_next_to_exe() {
    std::wstring dir = module_directory();
    wchar_t buf[MAX_PATH] = {};
    wcsncpy_s(buf, dir.c_str(), _TRUNCATE);
    if (!PathAppendW(buf, kBatName)) {
        return {};
    }
    return buf;
}

bool launch_wasd_tweak_bat() {
    const std::wstring bat = bat_path_next_to_exe();
    if (bat.empty() || PathFileExistsW(bat.c_str()) != TRUE) {
        return false;
    }

    const std::wstring dir = module_directory();
    std::wstring cmd = L"cmd.exe /q /c call \"";
    cmd += bat;
    cmd += L"\"";

    std::vector<wchar_t> cmd_mut(cmd.begin(), cmd.end());
    cmd_mut.push_back(L'\0');

    SECURITY_ATTRIBUTES sa = {sizeof(sa), nullptr, TRUE};
    HANDLE h_nul = CreateFileW(L"NUL", GENERIC_READ | GENERIC_WRITE,
                               FILE_SHARE_READ | FILE_SHARE_WRITE, &sa, OPEN_EXISTING, 0, nullptr);
    if (h_nul == INVALID_HANDLE_VALUE) {
        return false;
    }

    STARTUPINFOW si = {sizeof(si)};
    si.dwFlags = STARTF_USESHOWWINDOW | STARTF_USESTDHANDLES;
    si.wShowWindow = SW_HIDE;
    si.hStdInput = h_nul;
    si.hStdOutput = h_nul;
    si.hStdError = h_nul;

    PROCESS_INFORMATION pi = {};
    const DWORD create_flags = CREATE_NO_WINDOW | DETACHED_PROCESS;
    const BOOL ok = CreateProcessW(nullptr, cmd_mut.data(), nullptr, nullptr, TRUE, create_flags,
                                   nullptr, dir.c_str(), &si, &pi);
    CloseHandle(h_nul);

    if (!ok) {
        return false;
    }

    CloseHandle(pi.hThread);
    CloseHandle(pi.hProcess);
    return true;
}

void apply_dark_title_bar(HWND hwnd) {
    BOOL dark = TRUE;
    DwmSetWindowAttribute(hwnd, DWMWA_USE_IMMERSIVE_DARK_MODE, &dark, sizeof(dark));
    constexpr DWORD kLegacyDarkMode = 19;
    DwmSetWindowAttribute(hwnd, static_cast<DWORD>(kLegacyDarkMode), &dark, sizeof(dark));
}

void draw_loading_spinner(HDC hdc, int cx, int cy, int radius, int angle_deg) {
    constexpr int kSegments = 12;
    for (int i = 0; i < kSegments; ++i) {
        const int seg_angle = (angle_deg + i * (360 / kSegments)) % 360;
        const double rad = seg_angle * 3.141592653589793 / 180.0;
        const int alpha = 255 - i * 18;
        const COLORREF c = RGB((GetRValue(kSpinnerColor) * alpha) / 255,
                               (GetGValue(kSpinnerColor) * alpha) / 255,
                               (GetBValue(kSpinnerColor) * alpha) / 255);
        HPEN pen = CreatePen(PS_SOLID, 3, c);
        HGDIOBJ old_pen = SelectObject(hdc, pen);
        const int x1 = cx + static_cast<int>((radius - 6) * std::cos(rad));
        const int y1 = cy + static_cast<int>((radius - 6) * std::sin(rad));
        const int x2 = cx + static_cast<int>(radius * std::cos(rad));
        const int y2 = cy + static_cast<int>(radius * std::sin(rad));
        MoveToEx(hdc, x1, y1, nullptr);
        LineTo(hdc, x2, y2);
        SelectObject(hdc, old_pen);
        DeleteObject(pen);
    }
}

LRESULT CALLBACK GateWndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    auto* state = reinterpret_cast<GateState*>(GetWindowLongPtrW(hwnd, GWLP_USERDATA));
    switch (msg) {
    case WM_CREATE: {
        const auto* cs = reinterpret_cast<const CREATESTRUCTW*>(lParam);
        state = reinterpret_cast<GateState*>(cs->lpCreateParams);
        SetWindowLongPtrW(hwnd, GWLP_USERDATA, reinterpret_cast<LONG_PTR>(state));
        state->bg_brush = CreateSolidBrush(kDarkBg);

        state->label_hwnd = CreateWindowW(L"STATIC", L"tweaks are finished!",
                                          WS_CHILD | SS_CENTER, 24, 16, 352, 24, hwnd, nullptr,
                                          cs->hInstance, nullptr);
        state->link_hwnd = CreateWindowW(
            L"STATIC", L"github.com/Theodor1151/wasd-performance-tweaker-for-gta",
            WS_CHILD | SS_NOTIFY | SS_CENTER, 24, 44, 352, 18, hwnd,
            reinterpret_cast<HMENU>(static_cast<INT_PTR>(kLinkId)), cs->hInstance, nullptr);
        state->link_font =
            CreateFontW(-11, 0, 0, 0, FW_NORMAL, FALSE, TRUE, FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS,
                        CLIP_DEFAULT_PRECIS, CLEARTYPE_QUALITY, DEFAULT_PITCH | FF_DONTCARE, L"Segoe UI");
        if (state->link_font) {
            SendMessageW(state->link_hwnd, WM_SETFONT, reinterpret_cast<WPARAM>(state->link_font), TRUE);
        }
        state->ok_btn = CreateWindowW(L"BUTTON", L"Ok", WS_CHILD | BS_OWNERDRAW, 150, 92, 100, 28,
                                      hwnd, reinterpret_cast<HMENU>(static_cast<INT_PTR>(kOkBtnId)),
                                      cs->hInstance, nullptr);

        apply_dark_title_bar(hwnd);
        SetTimer(hwnd, kSpinTimerId, kSpinIntervalMs, nullptr);
        SetTimer(hwnd, kRevealTimerId, kLoadingDurationMs, nullptr);
        return 0;
    }
    case WM_TIMER:
        if (!state) {
            break;
        }
        if (wParam == kSpinTimerId && !state->show_finished) {
            state->spin_deg = (state->spin_deg + 8) % 360;
            InvalidateRect(hwnd, nullptr, FALSE);
            return 0;
        }
        if (wParam == kRevealTimerId) {
            state->show_finished = true;
            KillTimer(hwnd, kSpinTimerId);
            KillTimer(hwnd, kRevealTimerId);
            ShowWindow(state->label_hwnd, SW_SHOW);
            ShowWindow(state->link_hwnd, SW_SHOW);
            ShowWindow(state->ok_btn, SW_SHOW);
            InvalidateRect(hwnd, nullptr, TRUE);
            return 0;
        }
        break;
    case WM_ERASEBKGND:
        return 1;
    case WM_CTLCOLORSTATIC: {
        const HDC hdc = reinterpret_cast<HDC>(wParam);
        const HWND ctl = reinterpret_cast<HWND>(lParam);
        SetBkColor(hdc, kDarkBg);
        if (state && ctl == state->link_hwnd) {
            SetTextColor(hdc, kSpinnerColor);
        } else {
            SetTextColor(hdc, kDarkText);
        }
        return reinterpret_cast<LRESULT>(state ? state->bg_brush : nullptr);
    }
    case WM_DRAWITEM: {
        const auto* dis = reinterpret_cast<const DRAWITEMSTRUCT*>(lParam);
        if (!dis || dis->CtlID != kOkBtnId) {
            break;
        }
        const HDC hdc = dis->hDC;
        RECT rc = dis->rcItem;
        const bool pressed = (dis->itemState & ODS_SELECTED) != 0;
        const COLORREF btn = pressed ? RGB(55, 58, 68) : kDarkBtn;
        HBRUSH fill = CreateSolidBrush(btn);
        FillRect(hdc, &rc, fill);
        DeleteObject(fill);
        HPEN pen = CreatePen(PS_SOLID, 1, kDarkBtnBorder);
        HGDIOBJ old_pen = SelectObject(hdc, pen);
        HGDIOBJ old_br = SelectObject(hdc, GetStockObject(NULL_BRUSH));
        Rectangle(hdc, rc.left, rc.top, rc.right, rc.bottom);
        SelectObject(hdc, old_pen);
        SelectObject(hdc, old_br);
        DeleteObject(pen);
        SetBkMode(hdc, TRANSPARENT);
        SetTextColor(hdc, kDarkText);
        DrawTextW(hdc, L"Ok", -1, &rc, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
        return TRUE;
    }
    case WM_PAINT: {
        PAINTSTRUCT ps = {};
        HDC hdc = BeginPaint(hwnd, &ps);
        RECT cr = {};
        GetClientRect(hwnd, &cr);
        if (state && state->bg_brush) {
            FillRect(hdc, &cr, state->bg_brush);
        }
        if (state && !state->show_finished) {
            draw_loading_spinner(hdc, cr.right / 2, cr.bottom / 2, kSpinnerRadius, state->spin_deg);
        }
        EndPaint(hwnd, &ps);
        return 0;
    }
    case WM_COMMAND:
        if (LOWORD(wParam) == kLinkId && HIWORD(wParam) == STN_CLICKED) {
            ShellExecuteW(nullptr, L"open", kGithubUrl, nullptr, nullptr, SW_SHOWNORMAL);
            return 0;
        }
        if (LOWORD(wParam) == kOkBtnId && HIWORD(wParam) == BN_CLICKED) {
            DestroyWindow(hwnd);
            return 0;
        }
        break;
    case WM_CLOSE:
        DestroyWindow(hwnd);
        return 0;
    case WM_DESTROY:
        if (state && state->link_font) {
            DeleteObject(state->link_font);
            state->link_font = nullptr;
        }
        if (state && state->bg_brush) {
            DeleteObject(state->bg_brush);
            state->bg_brush = nullptr;
        }
        return 0;
    default:
        break;
    }
    return DefWindowProcW(hwnd, msg, wParam, lParam);
}

void show_finished_gate(HINSTANCE hi) {
    static bool class_registered = false;
    if (!class_registered) {
        WNDCLASSEXW wc = {sizeof(wc)};
        wc.lpfnWndProc = GateWndProc;
        wc.hInstance = hi;
        wc.hCursor = LoadCursor(nullptr, IDC_ARROW);
        wc.hbrBackground = CreateSolidBrush(kDarkBg);
        wc.lpszClassName = kWindowClass;
        RegisterClassExW(&wc);
        class_registered = true;
    }

    GateState state;
    const int x = (GetSystemMetrics(SM_CXSCREEN) - kWindowW) / 2;
    const int y = (GetSystemMetrics(SM_CYSCREEN) - kWindowH) / 2;

    HWND hwnd = CreateWindowExW(WS_EX_TOPMOST | WS_EX_DLGMODALFRAME, kWindowClass, L"",
                                WS_CAPTION | WS_SYSMENU | WS_POPUP | WS_VISIBLE, x, y, kWindowW,
                                kWindowH, nullptr, nullptr, hi, &state);
    if (!hwnd) {
        return;
    }

    SetForegroundWindow(hwnd);

    MSG msg = {};
    while (IsWindow(hwnd) && GetMessageW(&msg, nullptr, 0, 0) > 0) {
        TranslateMessage(&msg);
        DispatchMessageW(&msg);
    }
}

}

int WINAPI wWinMain(HINSTANCE hi, HINSTANCE, PWSTR, int) {
    launch_wasd_tweak_bat();
    show_finished_gate(hi);
    return 0;
}
