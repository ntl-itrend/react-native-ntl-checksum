import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  getChecksum(): Promise<string>;
  getChecksumCert(certPath: string): Promise<string>;
  getSumMETA(): Promise<string>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('NtlChecksum');
