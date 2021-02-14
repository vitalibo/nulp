; my_cam.asm
; Copyright (c) 2011 by Боярський Віталій

.586
.model flat,stdcall
    option casemap:none
    include my_cam.Inc
.code
begin:
    invoke GetModuleHandle,NULL
    mov hInstance,eax

    invoke GetCommandLine
    mov CommandLine,eax

    invoke WinMain,hInstance,NULL,CommandLine,SW_SHOWDEFAULT

    invoke ExitProcess,eax
    ret


WinMain proc hInst:HINSTANCE, hPrevInst:HINSTANCE, CmdLine:LPSTR, CmdShow:DWORD
    LOCAL wc:WNDCLASSEX
    LOCAL msg:MSG

    mov wc.cbSize,sizeof WNDCLASSEX
    mov wc.style,CS_HREDRAW or CS_VREDRAW
    mov wc.lpfnWndProc, offset WndProc
    mov wc.cbClsExtra,NULL
    mov wc.cbWndExtra,NULL
    push hInstance
    pop wc.hInstance
    mov wc.hbrBackground,COLOR_BTNFACE+1
    mov wc.lpszMenuName,NULL
    mov wc.lpszClassName,offset ClassName

    invoke LoadIcon,hInstance,ID_ICON
    mov wc.hIcon,eax
    mov wc.hIconSm,eax

    invoke LoadCursor,NULL,IDC_ARROW
    mov wc.hCursor,eax

    invoke RegisterClassEx,addr wc
    invoke CreateWindowEx,NULL,addr ClassName,addr AppName,\
        WS_SIZEBOX xor WS_EX_CONTROLPARENT xor WS_OVERLAPPEDWINDOW,\
        CW_USEDEFAULT,CW_USEDEFAULT,320,240,NULL,NULL,hInstance,NULL
    mov ghWndMain,eax

    invoke ShowWindow,ghWndMain,SW_SHOWNORMAL
    invoke UpdateWindow,ghWndMain

    .WHILE TRUE
        invoke GetMessage,addr msg,NULL,NULL,NULL
        .BREAK .IF (!eax)
        invoke TranslateMessage,addr msg
        invoke DispatchMessage,addr msg
    .ENDW

    mov eax,msg.wParam
    ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    .IF uMsg==WM_DESTROY
        invoke OnDestroy
    .ELSEIF uMsg==WM_CREATE
        invoke OnCreate,hWnd
    .ELSEIF uMsg==WM_COMMAND
        invoke OnCommand,hWnd,wParam
    .ELSE
        invoke DefWindowProc,hWnd,uMsg,wParam,lParam
        ret
    .ENDIF
    xor eax,eax
    ret
WndProc endp


OnDestroy proc
    invoke SendMessage,ghWndCap,WM_CAP_DRIVER_DISCONNECT,addr ghWndTitle,NULL
    invoke PostQuitMessage,NULL
    xor eax,eax
    ret
OnDestroy endp

OnCreate proc hWnd:HWND
    LOCAL hMenu:HMENU
    LOCAL hPMFile,hPMCap,hPMOption,hPMHelp:HMENU

    invoke CreateMenu
    mov hMenu,eax

    invoke CreatePopupMenu
    mov hPMFile,eax
    invoke AppendMenu,hPMFile,MF_STRING,IDM_EXIT,addr szExit
    invoke AppendMenu,hMenu,MF_POPUP,hPMFile,addr szMFile

    invoke CreatePopupMenu
    mov hPMCap,eax
    invoke AppendMenu,hPMCap,MF_STRING,IDM_CAP_START,addr szCapStart
    invoke AppendMenu,hPMCap,MF_STRING,IDM_CAP_STOP,addr szCapStop
    invoke AppendMenu,hPMCap,MF_SEPARATOR,NULL,NULL
    invoke AppendMenu,hPMCap,MF_STRING,IDM_CAP_SAVEDIB,addr szCapSave
    invoke AppendMenu,hPMCap,MF_STRING,IDM_CAP_VIDEORECORD,addr szCapRecord
    invoke AppendMenu,hPMCap,MF_SEPARATOR,NULL,NULL
    invoke AppendMenu,hPMCap,MF_STRING,IDM_CAP_DETECT,addr szCapDetect
    invoke AppendMenu,hMenu,MF_POPUP,hPMCap,addr szMCap

    invoke CreatePopupMenu
    mov hPMOption,eax
    invoke AppendMenu,hPMOption,MF_STRING,IDM_CAP_VIDEOCOMPRESSION,addr szCapCompression
    invoke AppendMenu,hPMOption,MF_STRING,IDM_CAP_VIDEOFORMAT,addr szCapFormat
    invoke AppendMenu,hPMOption,MF_STRING,IDM_CAP_VIDEOSOURCE,addr szCapSource
    invoke AppendMenu,hMenu,MF_POPUP,hPMOption,addr szMOptions

    invoke CreatePopupMenu
    mov hPMHelp,eax
    invoke AppendMenu,hPMHelp,MF_STRING,IDM_ABOUT,addr szAbout
    invoke AppendMenu,hMenu,MF_POPUP,hPMHelp,addr szMHelp
    invoke SetMenu,hWnd,hMenu

    invoke capCreateCaptureWindow,addr ghWndTitle,WS_VISIBLE or WS_CHILD,0,0,640,480,hWnd,NULL
    mov ghWndCap,eax
    invoke SendMessage,ghWndCap,WM_CAP_SET_CALLBACK_ERRORA,NULL,addr capErrorCallback
    invoke SendMessage,ghWndCap,WM_CAP_SET_CALLBACK_STATUSA,NULL,addr capStatusCallback
    invoke SendMessage,ghWndCap,WM_CAP_SET_CALLBACK_FRAME,NULL,addr capFrameCallback

    xor eax,eax
    ret
OnCreate endp

OnCommand proc hWnd:HWND, wParam:WPARAM
    .IF wParam==IDM_CAP_START
        mov eax,NULL
        .WHILE eax==NULL
            invoke SendMessage,ghWndCap,WM_CAP_DRIVER_CONNECT,gwDeviceIndex,NULL
        .ENDW
        invoke SendMessage,ghWndCap,WM_CAP_SET_OVERLAY,1,NULL
        invoke SendMessage,ghWndCap,WM_CAP_SET_SCALE,NULL,NULL
        invoke SendMessage,ghWndCap,WM_CAP_SET_PREVIEWRATE,gdwFrameNum,NULL
        invoke SendMessage,ghWndCap,WM_CAP_SET_PREVIEW,1,NULL
        invoke SetWindowSize,hWnd
    .ELSEIF wParam==IDM_CAP_STOP
        invoke SendMessage,ghWndCap,WM_CAP_DRIVER_DISCONNECT,addr ghWndTitle,NULL
    .ELSEIF wParam==IDM_EXIT
        invoke DestroyWindow,hWnd
    .ELSEIF wParam==IDM_CAP_SAVEDIB
        invoke DialogBoxParam,hInstance,IDD_DLG_CLICK,hWnd,addr DlgProcClick,NULL
    .ELSEIF wParam==IDM_CAP_VIDEORECORD
        invoke DialogBoxParam,hInstance,IDD_DLG_RECORD,hWnd,addr DlgProcRecord,NULL
    .ELSEIF wParam==IDM_CAP_DETECT
        invoke DialogBoxParam,hInstance,IDM_DLG_DETECT,NULL,addr DlgProcDetect,NULL
    .ELSEIF wParam==IDM_CAP_VIDEOCOMPRESSION
        invoke SendMessage,ghWndCap,WM_CAP_DLG_VIDEOCOMPRESSION,NULL,NULL
    .ELSEIF wParam==IDM_CAP_VIDEOFORMAT
        invoke SendMessage,ghWndCap,WM_CAP_DLG_VIDEOFORMAT,NULL,NULL

        .IF eax!=NULL
            invoke SetWindowSize,hWnd
        .ENDIF
    .ELSEIF wParam==IDM_CAP_VIDEOSOURCE
        invoke SendMessage,ghWndCap,WM_CAP_DLG_VIDEOSOURCE,NULL,NULL
    .ELSEIF wParam==IDM_ABOUT
        invoke DialogBoxParam,hInstance,IDD_DLG_ABOUT,hWnd,addr DlgProcAbout,NULL
    .ENDIF
    xor eax,eax
    ret
OnCommand endp

OnHScroll proc hTBar:HWND, wParam:WPARAM,lParam:LPARAM
    mov eax,wParam
    and eax,0FFFFh
    .IF eax==TB_THUMBPOSITION || eax==TB_THUMBTRACK
        mov eax,wParam
        shr eax,16
        mov gnPixelDetect,eax
        invoke SendMessage,ghTBar,TBM_SETPOS,TRUE,gnPixelDetect
    .ELSEIF eax==SB_LINELEFT
        inc gnPixelDetect
        invoke SendMessage,ghTBar,TBM_SETPOS,TRUE,gnPixelDetect
    .ELSEIF eax==SB_LINERIGHT
        dec gnPixelDetect
        invoke SendMessage,ghTBar,TBM_SETPOS,TRUE,gnPixelDetect
    .ENDIF
    ret
OnHScroll endp

DlgProcRecord proc hWnd:HWND,uMsg:UINT, wParam:WPARAM,lParam:LPARAM
    LOCAL ghCapParams:CAPTUREPARMS
    LOCAL hDC:HDC
    LOCAL rc:RECT
    LOCAL bm:BITMAP

    .IF uMsg==WM_CLOSE
        invoke SendMessage,ghWndCap,WM_CAP_STOP,NULL,NULL
        invoke SetWindowText,ghWndMain,ghWndTitle
        invoke EndDialog,hWnd,NULL
    .ELSEIF uMsg==WM_INITDIALOG
        invoke LoadImage,hInstance,ID_REC_OFF,IMAGE_BITMAP,0,0,NULL
        mov hBitmap,eax
    .ELSEIF uMsg==WM_COMMAND
        .IF wParam==IDD_DLG_BUT_RECORD
            invoke SendMessage,ghWndCap,WM_CAP_GET_SEQUENCE_SETUP,sizeof CAPTUREPARMS,addr ghCapParams
            mov ghCapParams.fAbortLeftMouse,FALSE
            mov ghCapParams.fAbortRightMouse,FALSE
            mov ghCapParams.fMakeUserHitOKToCapture,FALSE
            mov ghCapParams.fYield,TRUE
            invoke SendMessage,ghWndCap,WM_CAP_SET_SEQUENCE_SETUP,sizeof CAPTUREPARMS,addr ghCapParams

            invoke RandomFileName,addr szFileName,addr szAVIFile
            invoke SendMessage,ghWndCap,WM_CAP_FILE_SET_CAPTURE_FILEA,NULL,addr szFileName
            invoke SendMessage,ghWndCap,WM_CAP_SEQUENCE,NULL,NULL

            .IF eax!=NULL
                   invoke LoadImage,hInstance,ID_REC_ON,IMAGE_BITMAP,0,0,NULL
                mov hBitmap,eax
            .ENDIF
            invoke InvalidateRect,hWnd,addr rc,TRUE
        .ELSEIF wParam==IDD_DLG_BUT_STOP
            invoke SendMessage,ghWndCap,WM_CAP_STOP,NULL,NULL

               invoke LoadImage,hInstance,ID_REC_OFF,IMAGE_BITMAP,0,0,NULL
            mov hBitmap,eax
            invoke InvalidateRect,hWnd,addr rc,TRUE
        .ELSEIF wParam==IDD_DLG_BUT_PLAY
            invoke SendMessage,ghWndCap,WM_CAP_FILE_GET_CAPTURE_FILEA,255,addr szFileName
            invoke ShellExecute,NULL,NULL,addr szFileName,NULL,NULL,SW_SHOW
        .ENDIF
       .ELSEIF uMsg==WM_PAINT
           invoke GetDC,hWnd
           mov hDC,eax
        invoke GetObject,hBitmap,sizeof BITMAP,addr bm
        invoke CreateCompatibleDC,hDC
        mov hdcMem,eax
        invoke SelectObject,hdcMem,hBitmap
        invoke BitBlt,hDC,160,12,bm.bmWidth,bm.bmHeight,hdcMem,0,0,SRCCOPY
           invoke ReleaseDC,hWnd,hDC
    .ELSE
        mov eax,FALSE
        ret
    .ENDIF
    xor eax,eax
    ret
DlgProcRecord endp

DlgProcClick proc hWnd:HWND,uMsg:UINT, wParam:WPARAM,lParam:LPARAM
    .IF uMsg==WM_CLOSE
        invoke EndDialog,hWnd,NULL
    .ELSEIF uMsg==WM_COMMAND
        .IF wParam==IDD_DLG_BUT_CLICK
            invoke RandomFileName,addr szFileName,addr szBMPFile
            invoke SendMessage,ghWndCap,WM_CAP_FILE_SAVEDIBA,NULL,addr szFileName
            invoke MessageBeep,MB_OK
        .ELSEIF wParam==IDD_DLG_BUT_BUF
            invoke SendMessage,ghWndCap,WM_CAP_EDIT_COPY,NULL,NULL
        .ELSEIF wParam==IDD_DLG_BUT_OPEN
            invoke ShellExecute,NULL,NULL,addr szFileName,NULL,NULL,SW_SHOW
        .ENDIF
    .ELSE
        mov eax,NULL
        ret
    .ENDIF
    xor eax,eax
    ret
DlgProcClick endp

DlgProcAbout proc hWnd:HWND,uMsg:UINT, wParam:WPARAM,lParam:LPARAM
    LOCAL hDC:HDC
    LOCAL bm:BITMAP

    .IF uMsg==WM_CLOSE || uMsg==WM_COMMAND && wParam==IDD_DLG_BUT_OK
        invoke EndDialog,hWnd,NULL
    .ELSEIF uMsg==WM_PAINT
           invoke LoadImage,hInstance,ID_LOGO,IMAGE_BITMAP,0,0,NULL
        mov hBitmap,eax
        invoke GetDC,hWnd
           mov hDC,eax
        invoke GetObject,hBitmap,sizeof BITMAP,addr bm
        invoke CreateCompatibleDC,hDC
        mov hdcMem,eax
        invoke SelectObject,hdcMem,hBitmap
        invoke BitBlt,hDC,10,20,bm.bmWidth,bm.bmHeight,hdcMem,0,0,SRCCOPY
           invoke ReleaseDC,hWnd,hDC
    .ELSE
        mov eax,NULL
        ret
    .ENDIF
    xor eax,eax
    ret
DlgProcAbout endp

DlgProcDetect proc hWnd:HWND,uMsg:UINT, wParam:WPARAM,lParam:LPARAM
    .IF uMsg==WM_CLOSE
        invoke KillTimer,hWnd,1
        invoke MemoryFree,lpDataBitmap
        mov ghDetectFrame,0
        invoke EndDialog,hWnd,NULL
    .ELSEIF uMsg==WM_INITDIALOG
        invoke MemoryAlloc,614400
        mov lpDataBitmap,eax

        mov ghDetectFrame,1
        invoke SendMessage,ghWndCap,WM_CAP_SET_CALLBACK_FRAME,NULL,addr capFrameCallback

        invoke SetTimer,hWnd,1,100,0

        invoke CreateWindowEx,NULL,addr TrackBarClass,addr TrackBarName,WS_GROUP or WS_CHILD or WS_VISIBLE \
             or SBS_HORZ,10,10,270,30,hWnd,0,hInstance,0
        mov ghTBar,eax
        invoke SendMessage,ghTBar,TBM_SETRANGEMIN,0,0
        invoke SendMessage,ghTBar,TBM_SETRANGEMAX,0,500
        invoke SendMessage,ghTBar,TBM_SETPAGESIZE,0,50
        invoke SendMessage,ghTBar,TBM_SETPOS,TRUE,gnPixelDetect
        invoke SetFocus,hWnd
    .ELSEIF uMsg==WM_HSCROLL
        invoke OnHScroll,ghTBar,wParam,lParam
    .ELSEIF uMsg==WM_TIMER
        mov eax,gnPixelDetect
        .IF h>eax
            invoke MessageBeep,0FFFFFFFFh
        .ENDIF
    .ELSE
        mov eax,NULL
        ret
    .ENDIF
    ret
DlgProcDetect endp

capErrorCallback proc hWnd:HWND, nErrID:DWORD, lpErrorText:DWORD
    LOCAL gachBuffer[100]:BYTE
    .IF hWnd==NULL
        mov eax,FALSE
        ret
    .ELSEIF nErrID==NULL
        mov eax,TRUE
        ret
    .ENDIF

    invoke wsprintf,addr gachBuffer,addr szErrorTitle,nErrID
    invoke MessageBox,hWnd,lpErrorText,addr gachBuffer,MB_OK or MB_ICONEXCLAMATION
    mov eax,TRUE
    ret
capErrorCallback endp

capFrameCallback proc hWnd:HWND, lpVHdr:DWORD
    LOCAL dwBufferLength,m:DWORD

    .IF hWnd==NULL
        mov eax,FALSE
        ret
    .ENDIF

    .IF ghDetectFrame==TRUE
        pushad
        mov edx,lpVHdr
        assume edx: PTR VIDEOHDR

        mov esi,[edx].lpData
        mov eax,[edx].dwBufferLength
        mov dwBufferLength,eax
        shr dwBufferLength,2

        mov edi,lpDataBitmap
        mov h,0
        mov m,0
        mov eax,0
        .WHILE eax<dwBufferLength
            push eax
            mov ebx,dword ptr [esi]
            mov ecx,dword ptr [edi]
            mov dword ptr [edi],ebx
            .if m==2
                invoke GetPixelDetect,ebx,ecx
                .IF eax==0
                    mov dword ptr [esi],ebx
                .ELSE
                    inc h
                    mov dword ptr [esi],0F0000000h
                .ENDIF
            .elseif m==3
                mov m,0
            .endif
            inc m
            pop eax
            add esi,4
            add edi,4
            inc eax
        .ENDW

        assume edx: NOTHING
        popad
    .ENDIF

    xor eax,eax
    ret
capFrameCallback endp

capStatusCallback proc hWnd:HWND, nID:DWORD, lpsz:LPCTSTR
    .IF hWnd==NULL
        mov eax,FALSE
        ret
    .ELSEIF nID==NULL
        invoke SetWindowText,ghWndMain,addr AppName
    .ELSE
        invoke SetWindowText,ghWndMain,lpsz
    .ENDIF
    mov eax,TRUE
    ret
capStatusCallback endp


GetPixelDetect proc cBase:DWORD, cBufer:DWORD
    invoke DisColouration,cBase,cBufer,0F0000000h
    mov cRed,eax

    invoke DisColouration,cBase,cBufer,0F000F0h
    mov cGreen,eax

    invoke DisColouration,cBase,cBufer,0F000h
    mov cBlue,eax

;    invoke DisColouration,cBase,cBufer,0F0h
;    mov cIntensity,eax

    .IF cRed==0 || cGreen==0 || cBlue==0 ; && cIntensity==0
        mov eax,0
    .ELSE
        mov eax,1
    .ENDIF
    ret
GetPixelDetect endp

DisColouration proc clBasePixel:DWORD, clBuferPixel:DWORD, clMaskPixel:DWORD
    LOCAL clBase:DWORD

    mov eax,clBasePixel
    and eax,clMaskPixel
    mov clBase,eax

    mov eax,clBuferPixel
    and eax,clMaskPixel

    .IF clBase==eax
        mov eax,0
    .ELSE
        mov eax,1
    .ENDIF
    ret
DisColouration endp


SetWindowSize proc hWnd:HWND
    LOCAL bmpFormat:BITMAPINFO
    invoke SendMessage,ghWndCap,WM_CAP_GET_VIDEOFORMAT,sizeof bmpFormat,addr bmpFormat

    invoke SetWindowPos,ghWndCap,NULL,0,0,bmpFormat.bmiHeader.biWidth,bmpFormat.bmiHeader.biHeight,SWP_SHOWWINDOW
    mov eax,bmpFormat.bmiHeader.biWidth
    add eax,6
    mov ebx,bmpFormat.bmiHeader.biHeight
    add ebx,48
    invoke SetWindowPos,hWnd,NULL,100,100,eax,ebx,SWP_SHOWWINDOW
    ret
SetWindowSize endp

RandomFileName proc szFName:DWORD, lpszFName:DWORD
    LOCAL sTime:SYSTEMTIME
    LOCAL sEsp:DWORD

    invoke GetLocalTime,addr sTime
    mov sEsp,esp
    xor eax,eax
    mov ax,sTime.wSecond
    push eax
    mov ax,sTime.wMinute
    push eax
    mov ax,sTime.wHour
    push eax
    mov ax,sTime.wDay
    push eax
    push offset frmFileName
    push offset szFileName
    call wsprintf
    mov esp,sEsp

    mov sEsp,esp
    xor eax,eax
    invoke wsprintf,szFName,lpszFName,addr szFileName
    mov esp,sEsp
    ret
RandomFileName endp


MemoryAlloc proc BufSize:DWORD
    add BufSize,4
    invoke GlobalAlloc,GMEM_MOVEABLE or GMEM_ZEROINIT,BufSize
    push eax
    invoke GlobalLock,eax
    pop [eax]
    add eax,4
    ret
MemoryAlloc endp

MemoryFree proc DataMem:DWORD
    mov eax,DataMem
    sub eax,4
    push [eax]
    invoke GlobalUnlock,eax
    call GlobalFree
    ret
MemoryFree endp

end begin