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
	 LONG RegOpenKeyEx(HKEY hKey,	//�Ѿ��򿪵ļ��ľ��������ֱ����������������
	 LPCTSTR lpSubKey,				//Ҫ�򿪵��Ӽ����ֵĵ�ַ
	 DWORD ulOptions,				//����ֵ������Ϊ0
	 REGSAM samDesired,				//�򿪷�ʽ���������д
	 PHKEY phkResult				//���صĴ򿪵��Ӽ��ľ��
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
	 LONG RegQueryValueEx(HKEY hKey,	//Ҫ��ѯ�ļ��ľ��
	 LPCTSTR lpValueName,				//Ҫ��ѯ�ļ�ֵ������
	 LPDWORD lpReserved,				//����ֵ
	 LPDWORD lpType,					//Ҫ��ѯ�����ݵ�����
	 LPBYTE lpData,						//Ҫ���صĲ�ѯ������
	 LPDWORD lpcbData					//Ԥ�õ����ݵĳ���
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
	//cout << "Succeed�� has got regedit info" << dwValue << endl;

	/*
	 LONG RegSetValueEx(HKEY hKey,	//Ҫ���õļ��ľ��
	 LPCTSTR lpValueName,			//Ҫ���ʵļ�ֵ������
	 LPDWORD lpReserved,			//����ֵ
	 DWORD dwType,					//Ҫ���õ����ݵ�����
	 const BYTE *lpData,			//Ҫ���õĽ�ֵ
	 DWORD cbData					//���ݵĳ���
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

		//������
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

		//����
		SwapMouseButton(1);
		//cout << "->left hand" << endl;
	}
	//����������رմ򿪵�key���
	::RegCloseKey(key);
	//cin >> dwValue;
	//return 0;

}
