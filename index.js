import React from 'react';
import { AppRegistry, FlatList, StyleSheet, Text, View } from 'react-native';

class RNWeatherResultsList extends React.Component {
  render() {
    return (
      <View style={ styles.container }>
        <FlatList
          data={ this.props.data }
          keyExtractor={(item) => item.id.toString()}
          renderItem={({item}) =>
            <Text style={ styles.item }>
              Temperature: { item.the_temp }{'\n'}
              Min: { item.min_temp }{'\n'}
              Max: { item.max_temp }{'\n'}
              State: { item.weather_state_name }{'\n'}
              Wind Speed: { item.wind_speed }{'\n'}
              Wind Direction: { item.wind_direction }{'\n'}
              Wind Direction Compass: { item.wind_direction_compass }{'\n'}
              Air Pressure: { item.air_pressure }{'\n'}
              Humidity: { item.humidity }{'\n'}
              Visibility: { item.visibility }{'\n'}
              Predictability: { item.predictability }{'\n'}
              Created: { item.created }{'\n'}
              Applicable Date: { item.applicable_date }
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
  },
  item: {
    padding: 10,
    fontSize: 18,
    height: 300,
  },
});

// Module name
AppRegistry.registerComponent('RNWeatherResultsList', () => RNWeatherResultsList);
