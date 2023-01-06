package com.ntlchecksum

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactMethod
import java.io.InputStream
import java.security.MessageDigest


class NtlChecksumModule internal constructor(context: ReactApplicationContext) :
  NtlChecksumSpec(context) {

  override fun getName(): String {
    return NAME
  }

  // Example method
  // See https://reactnative.dev/docs/native-modules-android
  // @ReactMethod
  // override fun multiply(a: Double, b: Double, promise: Promise) {
  //   promise.resolve(a * b)
  // }

  @ReactMethod
  override fun getChecksum(promise: Promise) {
    val hash: ByteArray
    val sb = StringBuilder()
    try {
      val file_name = "index.android.bundle"
      val assetManager = getReactApplicationContext().getAssets()
      val stream: InputStream = assetManager.open(file_name)
      if (stream == null) {
        promise.resolve("");
        return;
      }
      val size: Int = stream.available()
      val buffer = stream.readBytes()
      hash = MessageDigest.getInstance("SHA-256").digest(buffer)
      if(hash == null) {
        promise.resolve("")
        return
      }
      val md: MessageDigest
      for(i in hash) {
        sb.append(Integer.toString((i.toInt() and 0xff)+ 0x100, 16).substring(1))
      }
      promise.resolve(sb.toString())
      return
    } catch (e: Exception) {
      promise.resolve("")
    }
    // try {

    // } catch(Exception e){

    // }
      //  byte[] hash = null;
      //   StringBuilder sb = new StringBuilder();
      //   try {
      //       AssetManager assetManager = getReactApplicationContext().getAssets();
      //       InputStream stream = assetManager.open("index.android.bundle");
      //       if (stream == null) {
      //           promise.resolve("");
      //           return;
      //       }
      //       int size = stream.available();
      //       byte[] buffer = new byte[size];
      //       stream.read(buffer);
      //       stream.close();
      //       hash = MessageDigest.getInstance("SHA-256").digest(buffer);
      //       if (hash == null) {
      //           promise.resolve("");
      //           return;
      //       }

      //   } catch (Exception ex) {
      //       ex.printStackTrace();
      //       promise.resolve("");
      //       return;
      //   }

      //   MessageDigest md = null;
      //   try {
      //       for (int i = 0; i < hash.length; i++) {
      //           sb.append(Integer.toString((hash[i] & 0xff) + 0x100, 16).substring(1));
      //       }

      //       promise.resolve(sb.toString());
      //       return;
      //   } catch (Exception e) {
      //       e.printStackTrace();
      //       promise.resolve("");
      //       return;
      //   }
  }

  @ReactMethod
  override fun getChecksumCert(name: String, promise: Promise) {
    promise.resolve("cert")
  }

  companion object {
    const val NAME = "NtlChecksum"
  }
}
