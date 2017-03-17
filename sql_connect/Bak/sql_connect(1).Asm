.386
.model flat, stdcall  ;32 bit memory model
option casemap :none  ;case sensitive

include deneme.inc

.code

start:

	invoke GetModuleHandle,NULL
	mov		hInstance,eax

    invoke InitCommonControls
	invoke DialogBoxParam,hInstance,IDD_DIALOG1,NULL,addr DlgProc,NULL
	invoke ExitProcess,0

;########################################################################


Sqlbaglan proto :HWND


DlgProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM

	mov		eax,uMsg
	.if eax==WM_INITDIALOG

	.elseif eax==WM_COMMAND
		mov		eax,wParam
		.if ax==IDD_BUTTON1
			invoke ExitProcess,0
		.endif
			
		.if ax==IDD_BUTTON2
		
			;invoke SetDlgItemText,hWin,IDC_ISIM,Addr deneme
			;invoke MessageBoxEx,0,Addr deneme,Addr deneme,MB_OK,0
			
			;invoke GetDlgItemText,hWin,IDC_ISIM,addr dene,32
			
			
			;invoke SetDlgItemText,hWin,IDC_SOYISIM,addr dene
			
			
			invoke Sqlbaglan,hWin
			
		.endif
		
	.elseif eax==WM_CLOSE
		invoke EndDialog,hWin,0
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

DlgProc endp


Sqlbaglan proc hDialg:HWND
	
	invoke SQLAllocHandle, SQL_HANDLE_ENV, 0, addr hEnv
    .if ax==SQL_SUCCESS || ax==SQL_SUCCESS_WITH_INFO
       	invoke SQLSetEnvAttr, hEnv, SQL_ATTR_ODBC_VERSION, SQL_OV_ODBC3, NULL
       	.if ax==SQL_SUCCESS || ax==SQL_SUCCESS_WITH_INFO
           	invoke SQLAllocHandle, SQL_HANDLE_DBC, hEnv, addr hConn
            .if ax==SQL_SUCCESS || ax==SQL_SUCCESS_WITH_INFO
                 
                 invoke SQLDriverConnect, hConn, hDialg, addr strConnect, sizeof strConnect, addr buffer, sizeof buffer,\
                  0, SQL_DRIVER_NOPROMPT
                 
                 .if ax==SQL_SUCCESS || ax==SQL_SUCCESS_WITH_INFO
                 
                 
                 invoke SQLAllocHandle,SQL_HANDLE_STMT,hConn,addr hStmt
                 
                 invoke SQLExecDirect,hStmt,addr Komut,SQL_NTS
                 
                 .if ax==SQL_SUCCESS || ax==SQL_SUCCESS_WITH_INFO
                 
                 
                 	.while TRUE
                 		invoke SQLFetch,hStmt
                 		
                 		.if ax==SQL_SUCCESS
                 
                 		invoke SQLGetData,hStmt,2,SQL_C_CHAR,addr buffer2 ,sizeof buffer2,0
                 
                 		invoke SetDlgItemText,hDialg,IDC_ISIM,Addr buffer2
						
                 		invoke SQLGetData,hStmt,3,SQL_C_CHAR,addr buffer2 ,sizeof buffer2,0
                 
                 		invoke SetDlgItemText,hDialg,IDC_SOYISIM,Addr buffer2
						
						invoke SQLGetData,hStmt,5,SQL_C_CHAR,addr buffer2 ,sizeof buffer2,0
                 
                 		invoke SetDlgItemText,hDialg,IDC_ADRES,Addr buffer2
						
                 		invoke SQLGetData,hStmt,6,SQL_C_CHAR,addr buffer2 ,sizeof buffer2,0
                 
                 		invoke SetDlgItemText,hDialg,IDC_TELEFON,Addr buffer2
						
                 
                 		.else
                 			.break
                 		.endif		
                 		
                 	.endw
                 
                 
                 
                 .endif
                 .endif
			.endif
		.endif
	.endif
	ret

Sqlbaglan endp

end start
