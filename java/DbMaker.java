package org.lionsoul.ip2region;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;

public class DbMaker {
    private DbConfig dbConfig;
    private File ipSrcFile;
    private LinkedList<IndexBlock> indexPool;
    private LinkedList<HeaderBlock> headerPool;
    private File globalRegionFile = null;
    private HashMap<String, Integer> globalRegionMap = null;
    private HashMap<String, DataBlock> regionPtrPool = null;

    public DbMaker(DbConfig paramDbConfig, String paramString1, String paramString2)
            throws DbMakerConfigException, IOException {
        this.dbConfig = paramDbConfig;
        this.ipSrcFile = new File(paramString1);
        this.globalRegionMap = new HashMap<String, Integer>();
        this.regionPtrPool = new HashMap<String, DataBlock>();
        if (paramString2 != null)
            this.globalRegionFile = new File(paramString2);
        if (!this.ipSrcFile.exists())
            throw new IOException("Error: Invalid file path " + paramString1);
    }

    private void initDbFile(RandomAccessFile paramRandomAccessFile) throws IOException {
        paramRandomAccessFile.seek(0L);
        paramRandomAccessFile.write(new byte[8]);
        paramRandomAccessFile.write(new byte[this.dbConfig.getTotalHeaderSize()]);
        this.headerPool = new LinkedList<HeaderBlock>();
        this.indexPool = new LinkedList<IndexBlock>();
    }

    public void make(String paramString) throws IOException {
        /** 地域代码映射 */
        if (this.globalRegionFile != null) {
            System.out.println("+-Try to load the global region data ...");
            BufferedReader localBufferedReader = new BufferedReader(new FileReader(this.globalRegionFile));
            String localObject1 = null;
            while ((localObject1 = localBufferedReader.readLine()) != null) {
                String[] localObject2 = ((String) localObject1).split(",");
                if (localObject2.length != 5)
                    continue;
                this.globalRegionMap.put(localObject2[2], Integer.valueOf(localObject2[0]));
            }
            localBufferedReader.close();
            System.out.println("|--[Ok]");
        }
        
        /** 
         * 数据文件处理
         * 初始化文件结构，预留头部索引空间
         */
        BufferedReader localBufferedReader = new BufferedReader(new FileReader(this.ipSrcFile));
        Object localObject1 = new RandomAccessFile(paramString, "rw");
        initDbFile((RandomAccessFile) localObject1);
        System.out.println("+-Db file initialized.");
        System.out.println("+-Try to write the data blocks ... ");
        
        /*
         *  写数据块[不定长]/准备索引块
         */
        Object localObject2 = null;
        while ((localObject2 = localBufferedReader.readLine()) != null) {
            localObject2 = ((String) localObject2).trim();
            if ((((String) localObject2).length() == 0) || (((String) localObject2).charAt(0) == '#'))
                continue;
            int i = 0;
            int j = 0;
            if ((j = ((String) localObject2).indexOf(124, i + 1)) == -1)
                continue;
            String str1 = ((String) localObject2).substring(i, j);
            i = j + 1;
            if ((j = ((String) localObject2).indexOf(124, i + 1)) == -1)
                continue;
            String str2 = ((String) localObject2).substring(i, j);
            i = j + 1;
            String str3 = ((String) localObject2).substring(i);
            System.out.println("+-Try to process item " + (String) localObject2);
            addDataBlock((RandomAccessFile) localObject1, str1, str2, str3);
            System.out.println("|--[Ok]");
        }
        System.out.println("|--Data block flushed!");
        System.out.println("|--Data file pointer: " + ((RandomAccessFile) localObject1).getFilePointer() + "\n");
        System.out.println("+-Try to write index blocks ... ");
        
        /*
         *  写索引块[4k分区、12bytes每块]/准备头索引[8k定长、8bytes每块]
         */
        IndexBlock localIndexBlock = null;
        HeaderBlock localHeaderBlock = null;
        localIndexBlock = (IndexBlock) this.indexPool.getFirst();
        long l1 = localIndexBlock.getStartIp();
        long l2 = ((RandomAccessFile) localObject1).getFilePointer();
        //先写一个分区地址到头索引
        this.headerPool.add(new HeaderBlock(l1, (int) l2));
        int k = IndexBlock.getIndexBlockLength();
        int m = 0;
        // 索引块大小[每个分区340块]
        int n = this.dbConfig.getIndexBlockSize() / k - 1;
        Iterator<IndexBlock> localIterator1 = this.indexPool.iterator();
        while (localIterator1.hasNext()) {
            localIndexBlock = (IndexBlock) localIterator1.next();
            m++;
            if (m >= n) {
                //每到新分区，准备头索引
                localHeaderBlock = new HeaderBlock(localIndexBlock.getStartIp(),
                        (int) ((RandomAccessFile) localObject1).getFilePointer());
                this.headerPool.add(localHeaderBlock);
                m = 0;
            }
            //连续写入
            ((RandomAccessFile) localObject1).write(localIndexBlock.getBytes());
        }
        //最后再加上末尾的不全分区地址到头索引
        if (m > 0) {
            localIndexBlock = (IndexBlock) this.indexPool.getLast();
            localHeaderBlock = new HeaderBlock(localIndexBlock.getStartIp(),
                    (int) ((RandomAccessFile) localObject1).getFilePointer() - IndexBlock.getIndexBlockLength());
            this.headerPool.add(localHeaderBlock);
        }
        long l3 = ((RandomAccessFile) localObject1).getFilePointer();
        System.out.println("|--[Ok]");
        System.out.println("+-Try to write the super blocks ... ");
        
        //写引导索引
        ((RandomAccessFile) localObject1).seek(0L);     // 定位到头
        byte[] arrayOfByte = new byte[8];
        Util.writeIntLong(arrayOfByte, 0, l2);          // 索引开始的地方
        Util.writeIntLong(arrayOfByte, 4, l3 - k);      // 索引结束的地方
        ((RandomAccessFile) localObject1).write(arrayOfByte);
        
        System.out.println("|--[Ok]");
        System.out.println("+-Try to write the header blocks ... ");
        
        //写头索引
        Iterator<HeaderBlock> localIterator2 = this.headerPool.iterator();
        while (localIterator2.hasNext()) {
            HeaderBlock localObject3 = (HeaderBlock) localIterator2.next();
            ((RandomAccessFile) localObject1).write(((HeaderBlock) localObject3).getBytes());
        }
        
        //---------------------------------------------------------------------------------
        System.out.println("+-Try to write the copyright and release date info ... ");
        ((RandomAccessFile) localObject1).seek(((RandomAccessFile) localObject1).length());
        Object localObject3 = Calendar.getInstance();
        SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
        String str4 = "Created by lionsoul at " + localSimpleDateFormat.format(((Calendar) localObject3).getTime());
        ((RandomAccessFile) localObject1).write((int) (((Calendar) localObject3).getTime().getTime() / 1000L));
        ((RandomAccessFile) localObject1).write(str4.getBytes());
        System.out.println("|--[Ok]");
        localBufferedReader.close();
        ((RandomAccessFile) localObject1).close();
    }

    private void addDataBlock(RandomAccessFile paramRandomAccessFile, String paramString1, String paramString2,
            String paramString3) {
        try {
            byte[] arrayOfByte = paramString3.getBytes("UTF-8");
            int i = 0;
            if (this.regionPtrPool.containsKey(paramString3)) {
                DataBlock localObject = (DataBlock) this.regionPtrPool.get(paramString3);
                i = ((DataBlock) localObject).getDataPtr();
                System.out.println("dataPtr: " + i + ", region: " + paramString3);
            } else {
                byte[] localObject = new byte[4];
                int j = getCityId(paramString3);
                Util.writeIntLong(localObject, 0, j);
                i = (int) paramRandomAccessFile.getFilePointer();
                paramRandomAccessFile.write(localObject);
                paramRandomAccessFile.write(arrayOfByte);
                this.regionPtrPool.put(paramString3, new DataBlock(j, paramString3, i));
            }
            Object localObject = new IndexBlock(Util.ip2long(paramString1), Util.ip2long(paramString2), i,
                    arrayOfByte.length + 4);
            this.indexPool.add((IndexBlock) localObject);
        } catch (UnsupportedEncodingException localUnsupportedEncodingException) {
            localUnsupportedEncodingException.printStackTrace();
        } catch (IOException localIOException) {
            localIOException.printStackTrace();
        }
    }

    public int getCityId(String paramString) {
        String[] arrayOfString = paramString.split("\\|");
        if (arrayOfString.length != 5)
            return 0;
        String str = null;
        Integer localInteger = null;
        for (int i = 3; i >= 0; i--) {
            if (arrayOfString[i].equals("0"))
                continue;
            if ((i == 3) && (arrayOfString[i].indexOf("省直辖县级") > -1))
                str = arrayOfString[2] + arrayOfString[3];
            else
                str = arrayOfString[i];
            localInteger = (Integer) this.globalRegionMap.get(str);
            if (localInteger == null)
                return 0;
            return localInteger.intValue();
        }
        return 0;
    }

    public DbConfig getDbConfig() {
        return this.dbConfig;
    }

    public DbMaker setDbConfig(DbConfig paramDbConfig) {
        this.dbConfig = paramDbConfig;
        return this;
    }

    public File getIpSrcFile() {
        return this.ipSrcFile;
    }

    public DbMaker setIpSrcFile(File paramFile) {
        this.ipSrcFile = paramFile;
        return this;
    }

    public static void main(String[] paramArrayOfString) {
        String str = "./data/";
        String[] arrayOfString = { null, null };
        for (int i = 0; i < paramArrayOfString.length; i++)
            if (paramArrayOfString[i].equals("-src")) {
                i++;
                arrayOfString[0] = paramArrayOfString[i];
            } else if (paramArrayOfString[i].equals("-region")) {
                i++;
                arrayOfString[1] = paramArrayOfString[i];
            } else {
                if (!paramArrayOfString[i].equals("-dst"))
                    continue;
                i++;
                str = paramArrayOfString[i];
            }
        for (int i = 0; i < arrayOfString.length; i++) {
            if (arrayOfString[i] != null)
                continue;
            System.out.println(
                    "Usage: java -jar dbMaker.jar -src [source text file path] -region [global region file path]");
            System.out.println(
                    "eg: java -jar dbMaker.jar -src ./data/ip.merge.txt -region ./data/origin/global_region.csv");
            System.exit(0);
        }
        if (!str.endsWith("/"))
            str = str + "/";
        try {
            DbConfig localDbConfig = new DbConfig();
            DbMaker localDbMaker = new DbMaker(localDbConfig, arrayOfString[0], arrayOfString[1]);
            localDbMaker.make(str + "ip2region.db");
        } catch (DbMakerConfigException localDbMakerConfigException) {
            localDbMakerConfigException.printStackTrace();
        } catch (IOException localIOException) {
            localIOException.printStackTrace();
        }
    }
}