window.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");

  if (!priceInput) return; // 出品ページ以外でエラーにならないように

  priceInput.addEventListener("input", () => {
    const price = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    // 数値に変換（空欄のときは0扱い）
    const priceValue = Number(price);

    // 販売手数料（10%）
    const tax = Math.floor(priceValue * 0.1);

    // 利益
    const profit = priceValue - tax;

    addTaxDom.innerHTML = tax;
    profitDom.innerHTML = profit;
  });
});