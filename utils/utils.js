export const filterCurrency = (str) => {
  return Number(str.replace(/[^0-9]/g, ""));
}