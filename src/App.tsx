import { useColorScheme } from "react-native";

import { COLORMODES } from "@gluestack-style/react/lib/typescript/types";
import { config } from "@gluestack-ui/config";
import { GluestackUIProvider } from "@gluestack-ui/themed";

import { LineChart } from "./LineChart";
import { GestureHandlerRootView } from "react-native-gesture-handler";

import { useAppDispatch } from "./services/hooks";

import { setData } from "./services/stocks/stocksSlice";

interface DataProps {
  values: Record<string, unknown>[],
}

export interface AppProps {
  data: DataProps,
  ticker: string,
}

export default function App({props}: {props: AppProps}) {
  const dispatch = useAppDispatch();

  const colorMode = useColorScheme() as COLORMODES;

  const selectedPeriod = 0;
  const stockTicker = props.ticker;
  const data = props.data;

  dispatch(setData({selectedPeriod, stockTicker, data}));

  return (
      <GestureHandlerRootView style={{ flex: 1 }}>
        <GluestackUIProvider config={config} colorMode={colorMode}>
          <LineChart />
        </GluestackUIProvider>
      </GestureHandlerRootView>
  );
}