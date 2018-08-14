import React from 'react';
import {AppRegistry, FlatList, StyleSheet, Text, View} from 'react-native';

class RNWeatherResultsList extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <FlatList
          data={this.props.data}
          keyExtractor={(item) => item.id.toString()}
          renderItem={({item}) =>
            <Text style={styles.item}>
              Temperature: {item.the_temp}{'\n'}
              Condition: {item.weather_state_name}{'\n'}
              Time: {item.created}{'\n'}
              Min: {item.min_temp}{'\n'}
              Max: {item.max_temp}{'\n'}
              Date: {item.applicable_date}
            </Text>
          }
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 22,
  },
  item: {
    padding: 10,
    fontSize: 18,
    height: 176,
  },
});

// Module name
AppRegistry.registerComponent('RNWeatherResultsList', () => RNWeatherResultsList);
