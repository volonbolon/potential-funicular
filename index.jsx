/**
 * @format
 */

import { Provider } from "react-redux";
import { store } from "./src/services/store";

import {AppRegistry} from 'react-native';
import App from './src/App';

import {name as appName} from './app.json';

const AppWrapper = (props) => {
  const appProps = {
    data: props.data,
    ticker: props.ticker,
  }
  return (
    <Provider store={store}>
      <App props={appProps} />
    </Provider>
  );
};

AppRegistry.registerComponent(appName, () => AppWrapper);
