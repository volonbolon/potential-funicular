import { configureStore } from "@reduxjs/toolkit";
import { stocksSlice } from "./stocks/stocksSlice.ts";

export const store = configureStore({
    reducer: {
        stocks: stocksSlice.reducer,
    }
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;