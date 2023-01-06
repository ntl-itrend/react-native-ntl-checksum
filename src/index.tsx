import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-ntl-checksum' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

// @ts-expect-error
const isTurboModuleEnabled = global.__turboModuleProxy != null;

const NtlChecksumModule = isTurboModuleEnabled
  ? require('./NativeNtlChecksum').default
  : NativeModules.NtlChecksum;

const NtlChecksum = NtlChecksumModule
  ? NtlChecksumModule
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

function getChecksum(): Promise<string> {
  return NtlChecksum.getChecksum();
}

function getChecksumCert(certPath: string): Promise<string> {
  return NtlChecksum.getChecksumCert(certPath);
}

function getSumMETA(): Promise<string> {
  return NtlChecksum.getSumMETA();
}

export default {
  getChecksum,
  getChecksumCert,
  getSumMETA,
};
