import { Box } from "@gluestack-ui/themed";
import React from "react";

import { COLORMODES } from "@gluestack-style/react/lib/typescript/types";
import {
  Circle,
  LinearGradient,
  useFont,
  vec,
} from "@shopify/react-native-skia";
import { useColorScheme } from "react-native";
import { useDerivedValue, type SharedValue } from "react-native-reanimated";
import { Area, CartesianChart, Line, useChartPressState } from "victory-native";

import { Text as SKText } from "@shopify/react-native-skia";
import { BottomSection } from "./components/BottomSection";
import { useAppSelector } from "./services/hooks";
import { StockInfo } from "./services/stocks/stocksSlice";

const inter = require("../roboto.ttf");
const interBold = require("../roboto-bold.ttf");

export const LineChart = () => {
  const stockData = useAppSelector((state) => state.stocks.data);
  const stockTicker = useAppSelector((state) => state.stocks.stockTicker);
  const font = useFont(inter, 12);
  const chartFont = useFont(interBold, 30);
  const { state, isActive } = useChartPressState({ x: 0, y: { price: 0 } });
  const colorMode = useColorScheme() as COLORMODES;

  const value = useDerivedValue(() => {
    return "$" + state.y.price.value.value.toFixed(2);
  }, [state]);

  const labelColor = colorMode === "dark" ? "white" : "black";
  const lineColor = colorMode === "dark" ? "lightgrey" : "black";

  const tickMarks = ({payload, max = 10}: {payload: StockInfo[], max: number}) => {
    const payloadLength = payload.length;
    if (payloadLength <= max) {
      return payload;
    }
    const step = (payload.length - 1) / (max -1);
    const ticks: StockInfo[] = [];
    for (let idx = 0; idx < max; idx++) {
      const selectedIndex = ~~(idx * Math.round(step));
      const selectedItem = payload[selectedIndex];
      if (selectedItem) { 
        ticks.push(selectedItem);
      }
    }
    return ticks;
  };

  return (
    <Box
      width="100%"
      $dark-bg="$black"
      $light-bg="$white"
      flex={1}
      alignItems="center"
      paddingHorizontal={5}
      paddingVertical={30}
    >
      <Box paddingTop={10} width="95%" height="60%">
        <CartesianChart
          data={stockData}
          xKey="day"
          yKeys={["price"]}
          domainPadding={{ top: 30 }}
          xAxis={{
            font,
            tickCount: tickMarks({payload: stockData, max: 10}).length,
            tickValues: tickMarks({payload: stockData, max: 10}).map((dp) => dp.day),
            labelOffset: 2,
            labelColor,
            lineColor,
            labelPosition: 'outset',
          }}
          chartPressState={state}
        >
          {({ points, chartBounds }) => (
            <>
              <SKText
                x={chartBounds.left + 10}
                y={40}
                font={chartFont}
                text={value}
                color={labelColor}
                style={"fill"}
              />
              <Line
                points={points.price}
                color="lightgrey"
                strokeWidth={3}
                animate={{ type: "timing", duration: 500 }}
              />
              <Area
                points={points.price}
                y0={chartBounds.bottom}
                color="lightgrey"
                animate={{ type: "timing", duration: 500 }}
              >
                <LinearGradient
                  start={vec(chartBounds.bottom, 200)}
                  end={vec(chartBounds.bottom, chartBounds.bottom)}
                  colors={["lightgrey", "#90ee9050"]}
                />
              </Area>

              {isActive ? (
                <ToolTip x={state.x.position} y={state.y.price.position} />
              ) : null}
            </>
          )}
        </CartesianChart>
      </Box>
      <BottomSection />
    </Box>
  );
};

function ToolTip({ x, y }: { x: SharedValue<number>; y: SharedValue<number> }) {
  return <Circle cx={x} cy={y} r={8} color={"grey"} opacity={0.8} />;
}