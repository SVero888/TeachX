#!/bin/bash
npm install
dfx start --clean --background
dfx generate
npm run build
dfx deploy
npm run frontend