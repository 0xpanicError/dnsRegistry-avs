"use strict";
const app = require("./configs/app.config");
const PORT = process.env.PORT || 4002;

app.listen(PORT, () => {
  console.log(`AVS Implementation listening on localhost:${PORT}`);
});