import React, {Component} from "react"

const api_url = `http://localhost:3001/api/v1/forecast?location=denver,co`

class CurrentWeather extends Component {
  contructor(props) {
    super(props)
    this.state = {
      
    }
  }
}

// function search(query) {
//   return fetch(`/api/food?q=${query}`, {
//     accept: 'application/json',
//   }).then(checkStatus)
//     .then(parseJSON);
// }
