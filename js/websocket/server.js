let http = require("http");
const hostname = "127.0.0.1";
const port = "9090";
 
// 创建一个http服务
let server = http.createServer((req, res) => {
    // 收到请求
    console.log("recv request");
    console.log(req.headers);
    // 进行响应，发送数据
    // res.write('hello, world');
    // res.end();
});
 
// 开始监听
server.listen(port, hostname, () => {
    // 启动成功
    console.log(`Server running at ${hostname}:${port}`);
});

let sha1 = require('sha1');
// 协议升级
server.on("upgrade", (request, socket, head) => {
    //console.log(request.headers);
    //let base64Value = '';
    
    // 取出浏览器发送的key值
    let secKey = request.headers['sec-websocket-key'];
    // RFC 6455规定的全局标志符(GUID)
    const UNIQUE_IDENTIFIER = '258EAFA5-E914-47DA-95CA-C5AB0DC85B11';
    // 计算sha1和base64值
    let shaValue = sha1(secKey + UNIQUE_IDENTIFIER),
        base64Value = Buffer.from(shaValue, 'hex').toString('base64');
    
    
    // 第一行是响应行（Response line），返回状态码101
    socket.write('HTTP/1.1 101 Web Socket Protocol Handshake\r\n' +
        // http响应头部字段用\r\n隔开
        'Upgrade: WebSocket\r\n' +
        'Connection: Upgrade\r\n' +
        // 这是一个给浏览器确认身份的字符串
        `Sec-WebSocket-Accept: ${base64Value}\r\n` +
        '\r\n');
        
    socket.on('data', buffer => {
        console.log('buffer len = ', buffer.length);
        console.log(buffer);
        
        // ------------------------
        
        let bitBuffer = new BitBuffer(buffer);
        let maskFlag = bitBuffer._getBit(8);
        console.log('maskFlag = ' + maskFlag);
        
        let payloadLen = bitBuffer.getBit(9, 7),
            maskKeys = bitBuffer.getMaskingKey(16);
        
        console.log('pLength = ' + payloadLen);
        console.log('maskKey = ' + maskKeys + 
        '[' + bitBuffer.bytesToHexString(maskKeys[0]) + ' ' + 
        bitBuffer.bytesToHexString(maskKeys[1]) + ' ' +
        bitBuffer.bytesToHexString(maskKeys[2]) + ' ' + 
        bitBuffer.bytesToHexString(maskKeys[3]) + ']');
        
        let payloadText = bitBuffer.getXorString(48 / 8, payloadLen, maskKeys);
        console.log('payloadText = ' + payloadText);
        
    });
});

class BitBuffer {
    
    // 构造函数传一个Buffer对象
    constructor (buffer) {
        this.buffer = buffer;
        this.hexChar = ['0', '1', '2', '3', '4', '5', 
            '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'];
    }
    // 获取第offset个位的内容
    _getBit (offset) {
        let byteIndex = offset / 8 >> 0,
            byteOffset = offset % 8;
        // readUInt8可以读取第n个字节的数据
        // 取出这个数的第m位即可
        let num = this.buffer.readUInt8(byteIndex) & (1 << (7 - byteOffset));
        return num >> (7 - byteOffset);
    }
    
    // 获取位 [from, length]
    getBit (offset, len = 1) {
        let result = 0;
        for (let i = 0; i < len; i++) {
            result += this._getBit(offset + i) << (len - i - 1); 
        }   
        return result;
    }
    
    // 获取掩码密钥
    getMaskingKey (offset) {
        const BYTE_COUNT = 4;
        let masks = []; 
        for (let i = 0; i < BYTE_COUNT; i++) {
            masks.push(this.getBit(offset + i * 8, 8));
        }   
        return masks;
    }
    
    // 获取明文
    getXorString (byteOffset, byteCount, maskingKeys) {
        let text = ''; 
        let hex  = '';
        for (let i = 0; i < byteCount; i++) {
            let j = i % 4;
            // 通过异或得到原始的utf-8编码
            let transformedByte = this.buffer.readUInt8(byteOffset + i)
                                      ^ maskingKeys[j];
            // 把编码值转成对应的字符
            text += String.fromCharCode(transformedByte);
            hex += this.bytesToHexString(transformedByte) + ' ';
        }
        console.log('payloadHex  = ' + hex);
        return text;
    }
    
    // 转16进制
    bytesToHexString(num) {
        let text = '';
        text += this.hexChar[num >>> 4 & 0xf];
        text += this.hexChar[num & 0xf];
        return text;
    }
}

