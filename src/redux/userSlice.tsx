import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  isAuthenticated: false,
  identity: "",
}

const userSlice = createSlice({
  name: "user",
  initialState,
  reducers: {
    addUser: (state, action) => {
      const { isAuthenticated, identity } = action.payload;
      state.isAuthenticated = isAuthenticated;
      state.identity = identity;
    }
  }
});

export const { addUser } = userSlice.actions;
export default userSlice.reducer; 