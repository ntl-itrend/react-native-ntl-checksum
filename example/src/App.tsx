import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import RNCheckSum from 'react-native-ntl-checksum';

export default function App() {
  const [result, setResult] = React.useState<string | undefined>();
  const [cert, setCert] = React.useState<string | undefined>();

  React.useEffect(() => {
    RNCheckSum.getChecksum().then(setResult);
    RNCheckSum.getChecksumCert('asdasd').then(setCert);
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
      <Text>Result: {cert}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
