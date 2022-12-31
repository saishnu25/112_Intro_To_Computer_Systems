#include <windows.h>

#include "resource.h" 

static char buf[255];
static char inputLabel[255];
HINSTANCE _hInstance;

BOOL CALLBACK DlgProc(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam)
{
	switch(Message)
	{
		case WM_INITDIALOG:
			// This is where we set up the dialog box, and initialise any default values
			SetDlgItemText(hwnd, IDC_LABEL, inputLabel);
			SetDlgItemText(hwnd, IDC_TEXT, "");
		break;

		case WM_COMMAND:
			switch(LOWORD(wParam))
			{
				case IDC_OK:
				{
					// When somebody clicks the Add button, first we get the number of
					// they entered

					int len = GetWindowTextLength(GetDlgItem(hwnd, IDC_TEXT));
					if(len > 0)
					{
						// get the string into our buffer and exit
						GetDlgItemText(hwnd, IDC_TEXT, buf, len + 1);
						EndDialog(hwnd, 0);
					}
					else 
					{
						MessageBox(hwnd, "Nothing entered", "Warning", MB_OK);
					}
				}
				break;
			}
		break;

		case WM_CLOSE:
			EndDialog(hwnd, 0);
		break;

		default:
			return FALSE;
	}
	return TRUE;
}

#pragma warning(disable : 4996)  // disable warning for strcpy
#pragma warning(disable : 4133)  // disable warning for DialogBox compatability

void getInput(char* inputPrompt, char* result, int maxChars)
// generate an input dialog with prompt as a label
// and a text box to input a string of up to maxChars characters,
// returned in result
{
	strcpy(inputLabel, inputPrompt);
	DialogBox(_hInstance, MAKEINTRESOURCE(IDD_MAIN), NULL, DlgProc);
	buf[maxChars-1] = '\0'; // in case too many characters, terminate string at maxChars
	strcpy(result, buf);
	return;
}

void showOutput(char* outputLabel, char* outputString)
// display a message box with outputLabel in the title bar
// and outputString in the main area
{
	MessageBox(NULL, outputString, outputLabel, MB_OK);
}

int MainProc(void);
// prototype for user's main program

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
	LPSTR lpCmdLine, int nCmdShow)
{
	_hInstance = hInstance;
	return MainProc();
}


