import React from 'react';
import {AppRegistry, FlatList, StyleSheet, Text, View} from 'react-native';

class RNWeatherResultsList extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <FlatList
          data={this.props['consolidated_weather']}
          renderItem={({item}) => <Text style={styles.item}>{item.max_temp}</Text>}
        />
      </View>
    );
  }
}

class RNHighScores extends React.Component {
  render() {
    var contents = this.props['consolidated_weather'].map((data) => (
      <Text key={data.max_temp}>
        {data.max_temp}:{data.value}
        {'\n'}
      </Text>
    ));
    return (
      <View style={styles.container}>
        <Text style={styles.highScoresTitle}>2048 High Scores!</Text>
        <Text style={styles.scores}>{contents}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  highScoresTitle: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  scores: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  item: {
    padding: 10,
    fontSize: 18,
    height: 44,
  },
});

// Module name
AppRegistry.registerComponent('RNWeatherResultsList', () => RNWeatherResultsList);
