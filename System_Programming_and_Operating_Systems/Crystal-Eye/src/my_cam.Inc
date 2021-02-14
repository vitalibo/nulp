; my_cam.inc
; Copyright (c) 2011 by Боярський Віталій
    
    include windows.inc
    include user32.inc
    include kernel32.inc
    include vfw32.inc
    include gdi32.inc
    include shell32.inc
    
    includelib user32.lib
    includelib kernel32.lib
    includelib vfw32.lib
    includelib gdi32.lib
    includelib shell32.lib

    WinMain                         proto :DWORD, :DWORD, :DWORD, :DWORD
    WndProc                         proto :HWND, :UINT, :WPARAM, :LPARAM

    DlgProcRecord                   proto :HWND, :UINT, :WPARAM, :LPARAM
    DlgProcClick                    proto :HWND, :UINT, :WPARAM, :LPARAM
    DlgProcAbout                    proto :HWND, :UINT, :WPARAM, :LPARAM
    DlgProcDetect                   proto :HWND, :UINT, :WPARAM, :LPARAM

    capErrorCallback                proto :HWND, :DWORD, :DWORD
    capFrameCallback                proto :HWND, :DWORD
    capStatusCallback               proto :HWND, :DWORD, :LPCTSTR
    OnHScroll                       proto :HWND, :WPARAM, :LPARAM

    OnDestroy                       proto
    OnCreate                        proto :HWND
    OnCommand                       proto :HWND, :WPARAM

    RandomFileName                  proto :DWORD, :DWORD
    SetWindowSize                   proto :HWND
    MemoryAlloc                     proto :DWORD
    MemoryFree                      proto :DWORD
    GetPixelDetect                  proto :DWORD, :DWORD
    DisColouration                  proto :DWORD, :DWORD, :DWORD

    ID_ICON                         equ 5000
    ID_LOGO                         equ 5001
    ID_REC_OFF                      equ 5002
    ID_REC_ON                       equ 5003

    IDM_EXIT                        equ 0FFFFFh
    IDM_CAP_START                   equ 800000h
    IDM_CAP_STOP                    equ 800001h
    IDM_CAP_SAVEDIB                 equ 800002h
    IDM_CAP_VIDEORECORD             equ 800003h
    IDM_CAP_DETECT                  equ 800004h
    IDM_CAP_VIDEOCOMPRESSION        equ 800005h
    IDM_CAP_VIDEOFORMAT             equ 800006h
    IDM_CAP_VIDEOSOURCE             equ 800007h
    IDM_ABOUT                       equ 800008h
    
    IDD_DLG_CLICK                   equ 10000
    IDD_DLG_BUT_CLICK               equ 10001
    IDD_DLG_BUT_OPEN                equ 10002
    IDD_DLG_BUT_BUF                 equ 10003
    
    IDD_DLG_RECORD                  equ 20000
    IDD_DLG_BUT_RECORD              equ 20001
    IDD_DLG_BUT_STOP                equ 20002
    IDD_DLG_BUT_PLAY                equ 20003
    
    IDD_DLG_ABOUT                   equ 30000
    IDD_DLG_BUT_OK                  equ 30001
    
    IDM_DLG_DETECT                  equ 40000
    
    TB_THUMBPOSITION                equ 04h
    TB_THUMBTRACK                   equ 05h
.data
    ClassName                       db 'AVICap Window Class Sample App',0
    AppName                         db 'Crystal Eye - Курсова робота',0
    ghWndTitle                      db 'Crystal Eye Cap',0
    TrackBarClass                   db 'msctls_trackbar32',0
    TrackBarName                    db 'Tarack Bar Nuber Pixel Detect',0
    
    frmFileName                     db '%d%d%d%d',0
    szFileName                      db 255 dup (0)
    szBMPFile                       db '%s.BMP',0
    szAVIFile                       db '%s.AVI',0
    
    szErrorTitle                    db 'Error : %d',0
    
    szMFile                         db 'File',0
    szExit                          db 'Exit',0
    szMCap                          db 'Camera',0
    szCapStart                      db 'Start',0
    szCapStop                       db 'Stop',0
    szCapSave                       db 'Click',0
    szCapRecord                     db 'Record',0
    szCapDetect                     db 'Detect',0
    szMOptions                      db 'Options',0
    szCapCompression                db 'Compression',0
    szCapFormat                     db 'Format',0
    szCapSource                     db 'Source',0
    szMHelp                         db 'Help',0
    szAbout                         db 'About',0
    
    gnPixelDetect                   dd 250
    gwDeviceIndex                   dd 0
    gdwFrameNum                     dd 10h
    ghDetectFrame                   dd 0
    
    VIDEOHDR STRUCT
        lpData                      LPBYTE 0
        dwBufferLength              DWORD 0
        dwBytesUsed                 DWORD 0
        dwTimeCaptured              DWORD 0
        dwUser                      DWORD 0
        dwFlags                     DWORD 0
        dwReserved                  DWORD 4 dup (0)
    VIDEOHDR ENDS
    
    CAPTUREPARMS STRUCT
        dwRequestMicroSecPerFrame   DWORD 0
        fMakeUserHitOKToCapture     BOOL 0
        wPercentDropForError        UINT 0
        fYield                      BOOL 0
        dwIndexSize                 DWORD 0
        wChunkGranularity           UINT 0
        fUsingDOSMemory             BOOL 0
        wNumVideoRequested          UINT 0
        fCaptureAudio               BOOL 0
        wNumAudioRequested          UINT 0
        vKeyAbort                   UINT 0
        fAbortLeftMouse             BOOL 0
        fAbortRightMouse            BOOL 0
        fLimitEnabled               BOOL 0
        wTimeLimit                  UINT 0
        fMCIControl                 BOOL 0
        fStepMCIDevice              BOOL 0
        dwMCIStartTime              DWORD 0
        dwMCIStopTime               DWORD 0
        fStepCaptureAt2x            BOOL 0
        wStepCaptureAverageFrames   UINT 0
        dwAudioBufferSize           DWORD 0
        fDisableWriteCache          BOOL 0
        AVStreamMaster              UINT 0
    CAPTUREPARMS ENDS
.data?
    hInstance                       HINSTANCE ?
    CommandLine                     LPSTR ?
    ghWndMain                       HWND ?
    ghWndCap                        HWND ?

    hBitmap                         HBITMAP ?
    hdcMem                          HDC ?
    lpDataBitmap                    DWORD ?
    ghTBar                          DWORD ?

    cRed                            DWORD ?
    cGreen                          DWORD ?
    cBlue                           DWORD ?
    cIntensity                      DWORD ?

    h                               DWORD ?
