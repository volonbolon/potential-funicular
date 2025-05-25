import { Box } from "@gluestack-ui/themed";
import React from "react";

import SegmentedControl from '@react-native-segmented-control/segmented-control';
import { useAppDispatch, useAppSelector } from "../services/hooks";
import { setSelectedPeriod } from "../services/stocks/stocksSlice";

export const BottomSection = () => {
  const dispatch = useAppDispatch();
  const selectedIndex = useAppSelector((state) => state.stocks.selectedPeriod);
  return (
    <>
      <Box
        marginTop={5}
        paddingTop={10}
        width="95%"
        height="30%"
        justifyContent="center"
      >
        <SegmentedControl
          values={['Week', 'Month', 'Year']}
          selectedIndex={selectedIndex}
          onChange={(event) => {
            const selectedIndex = event.nativeEvent.selectedSegmentIndex;
            dispatch(setSelectedPeriod(selectedIndex));
          }}
        />
      </Box>
    </>
  );
};