export const filterCurrency = (str) => {
  if (str == undefined) return 0
  return Number(str.replace(/[^0-9]/g, ""));
}