#-*- coding:utf-8 -*-
"""
" ip2region python seacher client module
"
" Author: koma<komazhang@foxmail.com>
" Date : 2015-11-06
"""
import struct, io, socket, sys

class Ip2Region(object):
    # 一对数组组成的符号表映射<IP, POSITION>
    __headerSip = []    # b-tree的内存引导节点'HEADER INDEX'起始IP
    __headerPtr = []    # b-tree的内存引导节点'HEADER INDEX'起始位置
    __f         = None  # 数据源文件   磁盘读写
    __sPtr      = 0     # 索引起始点   用于定位b-tree底层12bytes节点起始
    __indexLen  = 0     # 索引长度     用于定位b-tree底层12bytes节点个数
    __dbBinStr  = ''    # 数据源       内存读写

    def __init__(self, dbfile):
        self.initDatabase(dbfile)

"""
二分查找仅使用:
'SUPER BLOCK'  头部8字节
'INDEX BLOCK'  尾部 __indexLen * 12 的b-tree底层"外部节点"
"""

    # 内存二分查找
    def memorySearch(self, ip):
        """
        " memory search method
        " param: ip
        """
        if not ip.isdigit(): ip = self.ip2long(ip)

        if self.__dbBinStr == '':
            self.__dbBinStr = self.__f.read() #read all the contents in file
            self.__sPtr     = self.getLong(self.__dbBinStr, 0)
            endPtr          = self.getLong(self.__dbBinStr, 4)
            self.__indexLen = endPtr - self.__sPtr

        startPtr = self.__sPtr
        indexLen = self.__indexLen
        dbBinStr = self.__dbBinStr

        l, h, mixPtr = (0, int(indexLen/12), 0)
        while l <= h:
            m   = int((l+h)/2)
            ptr = startPtr + m*12

            sip = self.getLong(dbBinStr, ptr)
            eip = self.getLong(dbBinStr, ptr+4)

            # 内存中的二分查找
            if ip >= sip:
                if ip > eip:
                    l = m + 1
                else:
                    mixPtr = self.getLong(dbBinStr, ptr+8)
                    break;
            else:
                h = m - 1

        if mixPtr == 0: return "N2"

        return self.returnData(mixPtr)

    # 磁盘二分查找
    def binarySearch(self, ip):
        """
        " binary search method
        " param: ip
        """
        if not ip.isdigit(): ip = self.ip2long(ip)

        if self.__indexLen < 1:
            self.__f.seek(0)
            b = self.__f.read(8)
            self.__sPtr = self.getLong(b, 0)
            endPtr      = self.getLong(b, 4)
            self.__indexLen = endPtr - self.__sPtr

        startPtr = self.__sPtr
        indexLen = self.__indexLen

        self.__f.seek(startPtr)
        b = self.__f.read(indexLen+12)

        # 二分查找把db中的底层节点作为"数组"使用
        l, h, mixPtr = (0, int(indexLen/12), 0)
        while l <= h:
            m   = int((l+h)/2)
            ptr = startPtr + m*12
            self.__f.seek(ptr)

            # 磁盘中的二分查找需要多一步读取数据
            b   = self.__f.read(12)
            sip = self.getLong(b, 0)
            eip = self.getLong(b, 4)

            if ip >= sip:
                if ip > eip:
                    l = m + 1
                else:
                    mixPtr = self.getLong(b, 8)
                    break;
            else:
                h = m - 1

        if mixPtr == 0: return "N2"

        return self.returnData(mixPtr)

"""
这里的平衡树仅有两层：
    一层 根节点/内部节点   'HEADER INDEX'
    二层 子叶节点/外部节点 '4K-INDEX[12bytes-unit]'
"""
    # b-tree多节点平衡树查找
    def btreeSearch(self, ip):
        """
        " b-tree search method
        " param: ip
        """
        if not ip.isdigit(): ip = self.ip2long(ip)

        if len(self.__headerSip) < 1:
            #pass the super block
            self.__f.seek(8)
            #read the header block
            b = self.__f.read(8192)     # 读8k的b-tree引导块
            #parse the header block
            sip = None
            ptr = None
            for i in range(0, len(b)-1, 8): # 化整为零拆开引导块
                sip = self.getLong(b, i)
                ptr = self.getLong(b, i+4)
                if ptr == 0:
                    break
                self.__headerSip.append(sip)
                self.__headerPtr.append(ptr)

        headerLen = len(self.__headerSip) - 1
        l, h, sptr, eptr = (0, headerLen, 0, 0)

        # 对头引导索引做二分查找
        while l <= h:
            m = int((l+h)/2)

            if ip == self.__headerSip[m]:
                if m > 0:
                    sptr = self.__headerPtr[m-1]
                    eptr = self.__headerPtr[m]
                    break;
                else:
                    sptr = self.__headerPtr[m]
                    eptr = self.__headerPtr[m+1]
                    break;

            if ip > self.__headerSip[m]:
                if m == headerLen:
                    sptr = self.__headerPtr[m-1]
                    eptr = self.__headerPtr[m]
                    break;
                elif ip < self.__headerSip[m+1]:
                    sptr = self.__headerPtr[m]
                    eptr = self.__headerPtr[m+1]
                    break;

                l = m + 1
            else:
                if m == 0:
                    sptr = self.__headerPtr[m]
                    eptr = self.__headerPtr[m+1]
                    break;
                elif ip > self.__headerSip[m-1]:
                    sptr = self.__headerPtr[m-1]
                    eptr = self.__headerPtr[m]
                    break;

                h = m - 1

        if sptr == 0: return "N1"

        indexLen = eptr - sptr
        self.__f.seek(sptr)
        b = self.__f.read(indexLen + 12)
        
        l, h, mixPtr = (0, int(indexLen/12), 0)
        while l <= h:
            m = int((l+h)/2)
            offset = m * 12

            if ip >= self.getLong(b, offset):
                if ip > self.getLong(b, offset+4):
                    l = m + 1
                else:
                    mixPtr = self.getLong(b, offset+8)
                    break;
            else:
                h = m - 1

        if mixPtr == 0: return "N2"

        return self.returnData(mixPtr)

    def initDatabase(self, dbfile):
        """
        " initialize the database for search
        " param: dbFile
        """
        try:
            self.__f = io.open(dbfile, "rb")
        except IOError, e:
            print "[Error]: ", e
            sys.exit()

"""
获取数据，dsptr为 'INDEX'12字节的后4字节
其中:
    前1字节表示数据长度      ps. 1 ~ 2^8 bytes
    后3字节定位'DATA'位置    ps. 8+8192 ~ 2^24
"""
    def returnData(self, dsptr):
        """
        " get ip data from db file by data start ptr
        " param: dsptr
        """
        dataPtr = dsptr & 0x00FFFFFFL
        dataLen = (dsptr >> 24) & 0xFF
        
        self.__f.seek(dataPtr)
        data = self.__f.read(dataLen)

        return {
            "city_id": self.getLong(data, 0),
            "region" : data[4:]
        }

    def ip2long(self, ip):
        _ip = socket.inet_aton(ip)

        return struct.unpack("!L", _ip)[0]

    def isip(self, ip):
        p = ip.split(".")

        if len(p) != 4           : return False
        for pp in p:
            if not pp.isdigit()  : return False
            if len(pp) > 3       : return False
            if int(pp) > 255     : return False

        return True

    def getLong(self, b, offset):
        if len( b[offset:offset+4] ) == 4:
            return struct.unpack('I', b[offset:offset+4])[0]

        return 0

    def close(self):
        self.__headerSip = None
        self.__headerPtr = None
        self.__f.close()
        self.__f         = None
