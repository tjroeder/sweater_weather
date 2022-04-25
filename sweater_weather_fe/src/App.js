import React from 'react';
import './App.css';
import Header from './components/Header/Header.js.js'
import CurrentWeather from './components/CurrentWeather/CurrentWeather.js'
import DetailWeather from './components/DetailWeather/DetailWeather.js'
import ForecastWeather from './components/ForecastWeather/ForecastWeather.js'

function App() {
  return (
    <div className="App">
      <Header />
      {/* <header className="App-header">
        <h1>Sweater Weather</h1>
        <a href="/signup">Sign Up</a>
        <br/>
        <a href="/login">Login</a> */}
        <div class="locationCurrentWeather">
          <h2>Location Current Weather</h2>
        </div>
        <div class="weatherDetails">
          <h2>Weather Details</h2>
        </div>
        <div class="weatherForecast">
          <h2>Weather Forecast</h2>
        </div>
    </div>
  );
}

export default App;
