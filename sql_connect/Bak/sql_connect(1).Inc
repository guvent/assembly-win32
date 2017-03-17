
include windows.inc
include kernel32.inc
include user32.inc
include Comctl32.inc
include shell32.inc



include odbc32.inc

include odbccp32.inc


includelib kernel32.lib
includelib user32.lib
includelib Comctl32.lib
includelib shell32.lib


includelib odbc32.lib
includelib odbccp32.lib

DlgProc			PROTO	:HWND,:UINT,:WPARAM,:LPARAM

.const

IDD_DIALOG1			equ 101
IDD_BUTTON1			equ 1001
IDD_BUTTON2			equ 1010

IDC_ISIM			equ 1002
IDC_SOYISIM			equ 1004
IDC_TELEFON			equ 1005
IDC_ADRES			equ 1006

SQL_NULL			equ 0
SQL_OV				equ "3U"

;#########################################################################

.data

hata				db "Olmadý.!",0
tamam				db "Güzel :)",0

;ConnectStr			db "Driver=SQL Server;SERVER=DESKTOP-LI6D0Q5\\SQLEXPRESS;DATABASE=deneme;UID=sa;PWD=102030-g;",0
Komut				db "Select * From tablo",0

strConnect 			db "Driver=SQL Server;SERVER=DESKTOP-LI6D0Q5\SQLEXPRESS;DATABASE=deneme;UID=sa;PWD=102030-g;",0

.data?

hInstance			dd ?
dene				DWORD ?

hEnv				dd ?
hConn				dd ?
hStmt				dd ?

buffer db 1024 dup(?)
OutStringLength dd ?
OutBufferLength DWORD ?

buffer2 db 1024 dup(?)


Retconstr			db 256 dup(?)

okunan				db 1024 dup(?)




;#########################################################################



