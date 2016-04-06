//============================================================================
// Name        : SwapMouseButtons.cpp
// Author      : Chen
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include "windows.h"

using namespace std;

int main() {
	//cout << "Hello Mickey" << endl;

	/*
	 LONG RegOpenKeyEx(HKEY hKey,	//已经打开的键的句柄，或者直接是上述几个根键
	 LPCTSTR lpSubKey,				//要打开的子键名字的地址
	 DWORD ulOptions,				//保留值，必须为0
	 REGSAM samDesired,				//打开方式，如读还是写
	 PHKEY phkResult				//返回的打开的子键的句柄
	 );
	 */
	HKEY key;
	LPCTSTR SubKey = "Control Panel\\Mouse";
	if (::RegOpenKeyEx(HKEY_CURRENT_USER, SubKey, 0, KEY_ALL_ACCESS, &key) !=
	ERROR_SUCCESS) {
		//cout << "RegOpenKeyEx error" << endl;
		::RegCloseKey(key);
		//return 0;
	}
	//cout << "RegOpenKeyEx Succeed" << endl;
	//	::RegCloseKey(key);

	/*
	 LONG RegQueryValueEx(HKEY hKey,	//要查询的键的句柄
	 LPCTSTR lpValueName,				//要查询的键值的名称
	 LPDWORD lpReserved,				//保留值
	 LPDWORD lpType,					//要查询的数据的类型
	 LPBYTE lpData,						//要返回的查询的数据
	 LPDWORD lpcbData					//预置的数据的长度
	 );
	 */
	char dwValue[256];
	DWORD dwSize = sizeof(DWORD);
	DWORD dwType = REG_SZ;
	if (::RegQueryValueEx(key, "SwapMouseButtons", 0, &dwType,
			(LPBYTE) &dwValue, &dwSize) != ERROR_SUCCESS) {
		//cout << "Error: can't get regedit info" << endl;
		::RegCloseKey(key);
		//return 0;
	}
	//cout << "Succeed： has got regedit info" << dwValue << endl;

	/*
	 LONG RegSetValueEx(HKEY hKey,	//要设置的键的句柄
	 LPCTSTR lpValueName,			//要访问的键值的名称
	 LPDWORD lpReserved,			//保留值
	 DWORD dwType,					//要设置的数据的类型
	 const BYTE *lpData,			//要设置的健值
	 DWORD cbData					//数据的长度
	 );
	 */
	if (dwValue[0] == '1') {

		DWORD value = '0';
		if (ERROR_SUCCESS
				!= ::RegSetValueEx(key, "SwapMouseButtons", 0, REG_SZ,
						(CONST BYTE*) &value, 1)) {
			//cout << "write 0 error" << endl;
			::RegCloseKey(key);
			//return 0;
		}
		//cout << "write 0 succeed" << endl;

		//变正常
		SwapMouseButton(0);
		//cout << "->right hand" << endl;
	} else {
		DWORD value = '1';
		if (ERROR_SUCCESS
				!= ::RegSetValueEx(key, "SwapMouseButtons", 0, REG_SZ,
						(CONST BYTE*) &value, 1)) {
			//cout << "write 1 error" << endl;
			::RegCloseKey(key);
			//return 0;
		}
		//cout << "write 1 succeed" << endl;

		//调换
		SwapMouseButton(1);
		//cout << "->left hand" << endl;
	}
	//程序结束，关闭打开的key句柄
	::RegCloseKey(key);
	//cin >> dwValue;
	//return 0;

}
