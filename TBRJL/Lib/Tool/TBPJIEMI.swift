//
//  TBPJIEMI.swift
//  TBP
//
//  Created by admin on 15/1/29.
//  Copyright (c) 2015年 fjtsoft. All rights reserved.
//

import Foundation
import UIKit

class TBPJIEMI : NSObject {
    var Sbox:[UInt8] = [
        0xd6, 0x90, 0xe9, 0xfe, 0xcc, 0xe1, 0x3d, 0xb7, 0x16, 0xb6, 0x14, 0xc2, 0x28, 0xfb, 0x2c, 0x05,
        0x2b, 0x67, 0x9a, 0x76, 0x2a, 0xbe, 0x04, 0xc3, 0xaa, 0x44, 0x13, 0x26, 0x49, 0x86, 0x06, 0x99,
        0x9c, 0x42, 0x50, 0xf4, 0x91, 0xef, 0x98, 0x7a, 0x33, 0x54, 0x0b, 0x43, 0xed, 0xcf, 0xac, 0x62,
        0xe4, 0xb3, 0x1c, 0xa9, 0xc9, 0x08, 0xe8, 0x95, 0x80, 0xdf, 0x94, 0xfa, 0x75, 0x8f, 0x3f, 0xa6,
        0x47, 0x07, 0xa7, 0xfc, 0xf3, 0x73, 0x17, 0xba, 0x83, 0x59, 0x3c, 0x19, 0xe6, 0x85, 0x4f, 0xa8,
        0x68, 0x6b, 0x81, 0xb2, 0x71, 0x64, 0xda, 0x8b, 0xf8, 0xeb, 0x0f, 0x4b, 0x70, 0x56, 0x9d, 0x35,
        0x1e, 0x24, 0x0e, 0x5e, 0x63, 0x58, 0xd1, 0xa2, 0x25, 0x22, 0x7c, 0x3b, 0x01, 0x21, 0x78, 0x87,
        0xd4, 0x00, 0x46, 0x57, 0x9f, 0xd3, 0x27, 0x52, 0x4c, 0x36, 0x02, 0xe7, 0xa0, 0xc4, 0xc8, 0x9e,
        0xea, 0xbf, 0x8a, 0xd2, 0x40, 0xc7, 0x38, 0xb5, 0xa3, 0xf7, 0xf2, 0xce, 0xf9, 0x61, 0x15, 0xa1,
        0xe0, 0xae, 0x5d, 0xa4, 0x9b, 0x34, 0x1a, 0x55, 0xad, 0x93, 0x32, 0x30, 0xf5, 0x8c, 0xb1, 0xe3,
        0x1d, 0xf6, 0xe2, 0x2e, 0x82, 0x66, 0xca, 0x60, 0xc0, 0x29, 0x23, 0xab, 0x0d, 0x53, 0x4e, 0x6f,
        0xd5, 0xdb, 0x37, 0x45, 0xde, 0xfd, 0x8e, 0x2f, 0x03, 0xff, 0x6a, 0x72, 0x6d, 0x6c, 0x5b, 0x51,
        0x8d, 0x1b, 0xaf, 0x92, 0xbb, 0xdd, 0xbc, 0x7f, 0x11, 0xd9, 0x5c, 0x41, 0x1f, 0x10, 0x5a, 0xd8,
        0x0a, 0xc1, 0x31, 0x88, 0xa5, 0xcd, 0x7b, 0xbd, 0x2d, 0x74, 0xd0, 0x12, 0xb8, 0xe5, 0xb4, 0xb0,
        0x89, 0x69, 0x97, 0x4a, 0x0c, 0x96, 0x77, 0x7e, 0x65, 0xb9, 0xf1, 0x09, 0xc5, 0x6e, 0xc6, 0x84,
        0x18, 0xf0, 0x7d, 0xec, 0x3a, 0xdc, 0x4d, 0x20, 0x79, 0xee, 0x5f, 0x3e, 0xd7, 0xcb, 0x39, 0x48
    ];
    
    
    var CK:[UInt32] = [
        0x00070e15, 0x1c232a31, 0x383f464d, 0x545b6269,
        0x70777e85, 0x8c939aa1, 0xa8afb6bd, 0xc4cbd2d9,
        0xe0e7eef5, 0xfc030a11, 0x181f262d, 0x343b4249,
        0x50575e65, 0x6c737a81, 0x888f969d, 0xa4abb2b9,
        0xc0c7ced5, 0xdce3eaf1, 0xf8ff060d, 0x141b2229,
        0x30373e45, 0x4c535a61, 0x686f767d, 0x848b9299,
        0xa0a7aeb5, 0xbcc3cad1, 0xd8dfe6ed, 0xf4fb0209,
        0x10171e25, 0x2c333a41, 0x484f565d, 0x646b7279
    ];
    
    
    func Rotl(x:UInt32,y:UInt32) -> UInt32
    {
        var xx:UInt32 = UInt32(x);
        var yy:UInt32 = UInt32(y);
        var zz = xx<<yy|xx>>(32 - yy);
        return UInt32(zz);
    }

    func ByteSub(A:UInt32) -> UInt32
    {
        var step1 = UInt32(Sbox[Int(A >> 24 & 0xFF)] & 0xFF);
        step1 = step1 << 24;
        
        var step2 = UInt32(Sbox[Int(A >> 16 & 0xFF)] & 0xFF);
        step2 = step2 << 16 ;
        
        var step3 = UInt32(Sbox[Int(A >> 8 & 0xFF)] & 0xFF);
        step3 = step3 << 8;
        
        var step4 = UInt32(Sbox[Int(A & 0xFF)] & 0xFF);
        
        var step5 = step1|step2|step3|step4;
        
        return  step5;
    }
    
    
    func L1(B:UInt32) -> UInt32
    {
        return UInt32(B ^ Rotl(B,y: 2) ^ Rotl(B,y:10) ^ Rotl(B,y:18) ^ Rotl(B,y:24));
    }
    
    func L2(B:UInt32) -> UInt32
    {
        return UInt32(B) ^ Rotl(UInt32(B),y:13) ^ Rotl(UInt32(B),y:23);
    }
    
    func SMS4Crypt(Input:[UInt8],rk:[UInt32]) -> [UInt8]
    {
        var r,x0,x1,x2,x3:Int;
        var mid:UInt32;
        var x:[UInt32] = [0,0,0,0];
        var tmp:[UInt32] = [0,0,0,0];
        for(var i=0;i<4;i++)
        {
            tmp[0]=UInt32(Input[0+4*i]&0xff);
            tmp[1]=UInt32(Input[1+4*i]&0xff);
            tmp[2]=UInt32(Input[2+4*i]&0xff);
            tmp[3]=UInt32(Input[3+4*i]&0xff);
            
            x[i]=UInt32(tmp[0]<<24|tmp[1]<<16|tmp[2]<<8|tmp[3]);
        }
        for(r=0;r<32;r+=4)
        {
            mid = x[1]^x[2]^x[3]^UInt32(rk[r+0]);
            
            mid = ByteSub(mid);
            
            x[0] = x[0] ^ UInt32(L1(mid));   //x4
            
            mid = x[2]^x[3]^x[0]^UInt32(rk[r+1]);
            
            mid = ByteSub(mid);
            
            x[1] = x[1]^UInt32(L1(mid));	//x5
            
            mid = x[3]^x[0]^x[1]^UInt32(rk[r+2]);
            
            mid = ByteSub(mid);
            
            x[2] = x[2]^UInt32(L1(mid));	//x6
            
            mid = x[0]^x[1]^x[2]^UInt32(rk[r+3]);
            
            mid = ByteSub(mid);
            
            x[3] = x[3]^UInt32(L1(mid));	//x7
        }
        
        //Reverse
        var Output = [0 as UInt8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
        for(var j=0;j<16;j+=4)
        {
            Output[j]   = UInt8 (x[3-j/4] >> 24 & 0xFF)
            Output[j+1] = UInt8 ( x[3-j/4] >> 16 & 0xFF )
            Output[j+2] = UInt8 (x[3-j/4] >> 8 & 0xFF)
            Output[j+3] = UInt8 (x[3-j/4] & 0xFF)
        }
        return Output;
    }
    
    
    func SMS4KeyExt(Key:[UInt8],rk:[UInt32],CryptFlag:Int) -> [UInt32]
    {
        var rkcurr = rk;
        var r:Int;
        var mid:UInt32;
        var x:[UInt32] = [0,0,0,0];
        var tmp:[UInt32] = [0,0,0,0];
        for(var i=0;i<4;i++) {
            tmp[0]=UInt32(Key[0+4*i]&0xFF);
            tmp[1]=UInt32(Key[1+4*i]&0xff);
            tmp[2]=UInt32(Key[2+4*i]&0xff);
            tmp[3]=UInt32(Key[3+4*i]&0xff);
            
            x[i] = tmp[0]<<24|tmp[1]<<16|tmp[2]<<8|tmp[3];
            //	x[i]=Key[0+4*i]<<24|Key[1+4*i]<<16|Key[2+4*i]<<8|Key[3+4*i];
        }
        
        x[0] ^= 0xa3b1bac6;
        x[1] ^= 0x56aa3350;
        x[2] ^= 0x677d9197;
        x[3] ^= 0xb27022dc;
        
        for(r=0;r<32;r+=4)
        {
            mid = x[1] ^ x[2] ^ x[3] ^ CK[r+0];
            mid = ByteSub(mid);
            x[0] ^= UInt32(L2(mid));
            rkcurr[r+0] = x[0];
            
            mid = x[2]^x[3]^x[0]^CK[r+1];
            mid = ByteSub(mid);
            x[1] ^= UInt32(L2(mid));
            rkcurr[r+1] = x[1];
            
            mid = x[3]^x[0]^x[1]^CK[r+2];
            mid = ByteSub(mid);
            x[2] ^= UInt32(L2(mid));
            rkcurr[r+2] = x[2];
            
            
            
            mid = x[0]^x[1]^x[2]^CK[r+3];
            mid = ByteSub(mid);
            x[3] ^= UInt32(L2(mid));
            rkcurr[r+3] = x[3];
        }
        
        //解密时轮密钥使用顺序：rk31,rk30,...,rk0
        if(CryptFlag==1)
        {
            for(r=0;r<16;r++)
            {
                mid = rkcurr[r];
                
                rkcurr[r] = rkcurr[31-r];
                rkcurr[31-r] = mid;
            }
        }
        return rkcurr;
    }
    
    func sms4(inarr:[UInt8],inLen:Int,key:[UInt8]) -> [UInt8]
    {
        var point=0;
        var inLenx = inLen;
        var round_key:[UInt32] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];//必须32位
        
        round_key = SMS4KeyExt(key,rk:round_key,CryptFlag:1);
        var input = [0 as UInt8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
        var output = [0 as UInt8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
        input.removeAll(keepCapacity: false);
        var resultout = [0 as UInt8];
        resultout.removeAll(keepCapacity: false);
        
        while(inLenx >= 16)
        {
            input.removeAll(keepCapacity: false);
            for (var i = point;i<point+16;i++) {
                input.append(inarr[i]);
            }
            
            output = SMS4Crypt(input,rk:round_key);
            for (var i = 0;i<16;i++) {
                resultout.append(output[i]);
            }
            
            inLenx-=16;
            point+=16;
        }
        return resultout;
    }
    
    func JIEMI(rsstr:String) -> String
    {
        if rsstr.hasPrefix("sm4_")
        {
            //var strString = rsstr.substr(4);
            var strString=(rsstr as NSString).substringFromIndex(4);
            var restr2 = SMS4().DecodeSMS4(strString, withKey: "ad37d033dac44f6b919ff66a3477613a");
            if (restr2 == nil)
            {
                return "";
            }
            
            return restr2;
            
        }else
        {
            // 密文.按8859-1 格式读入 [CChar]
            var oldstr = rsstr.cStringUsingEncoding(NSISOLatin1StringEncoding);
            if oldstr == nil
            {
                return "";
            }
            var rsstrArr:[CChar] = oldstr!;
            var i = 0;
            for s:Int8 in rsstrArr
            {
                if s == 0 // 0是结尾标识。
                {
                    break;
                }
                //异或 1 然后转STRING 然后追加到结果中
                rsstrArr[i] = s^1;
                i++;
            }
            // 按 UTF8 输出
            var kao = String(CString: rsstrArr,encoding: NSUTF8StringEncoding);
            println("TBPJIEMI.JIEMI RETURN:\(kao)");
            if kao == nil
            {
                return "";
            }
            return kao!;
        }
    }
}

