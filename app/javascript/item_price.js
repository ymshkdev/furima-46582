const priceCalc = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const priceValue = Number(priceInput.value || 0);
    const tax = Math.floor(priceValue * 0.1);
    const profit = priceValue - tax;

    addTaxDom.innerHTML = tax;
    profitDom.innerHTML = profit;
  });
};

window.addEventListener("turbo:load", priceCalc);
window.addEventListener("turbo:render", priceCalc);