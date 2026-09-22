# Repository instructions

- Run `mix precommit` before declaring any code change complete.
- For LiveView or other UI changes, add a relevant LiveView test and verify the final behavior with Tidewave's browser tools.
- `mix credo --strict` has known existing cleanup debt and is intentionally outside the green precommit gate. Do not hide or suppress its findings; address them when they are in scope.
