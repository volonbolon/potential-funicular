import { createSlice } from "@reduxjs/toolkit";
import type { PayloadAction } from "@reduxjs/toolkit";
import { NativeModules } from "react-native";

export interface StockInfo {
    day: number,
    price: number,
}

export interface StockState {
    selectedPeriod: number,
    stockTicker: string,
    data: StockInfo[],
}

const initialState: StockState = {
    selectedPeriod: 0,
    stockTicker: "",
    data: [],
};

export const stocksSlice = createSlice({
    name: "stocks",
    initialState,
    reducers: {
        setData: {
            reducer(state, action: PayloadAction<StockState>) {
                state.data = action.payload.data;
                state.stockTicker = action.payload.stockTicker;
                state.selectedPeriod = action.payload.selectedPeriod;
            },
            prepare({selectedPeriod, stockTicker, data}: {selectedPeriod: number, stockTicker: string, data: StockInfo[]}) {
                const payload: StockState = {
                    selectedPeriod,
                    stockTicker,
                    data,
                }
                return {payload};
            }
        },
        setSelectedPeriod(state, action: PayloadAction<number>) {
            state.selectedPeriod = action.payload;

            const {StocksModule} = NativeModules;
            const values = StocksModule.getValues(state.selectedPeriod, state.stockTicker);
            
            state.data = values;
        }
    },
});

export const { setSelectedPeriod, setData} = stocksSlice.actions;

export default stocksSlice.reducer;