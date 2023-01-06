package com.ntlchecksum

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.Promise

abstract class NtlChecksumSpec internal constructor(context: ReactApplicationContext) :
  ReactContextBaseJavaModule(context) {

  // abstract fun multiply(a: Double, b: Double, promise: Promise)
  abstract fun getChecksum(promise: Promise)
  abstract fun getChecksumCert(name: String, promise: Promise)
}
