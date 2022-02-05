window.addEventListener('load', function(){
  const market_price = document.getElementById("item-price");
  if(!market_price){ return false;}
  market_price.addEventListener("input", () => {
  const inputValue = market_price.value;
  const addTaxDom = document.getElementById("add-tax-price");
  addTaxDom.innerHTML = (Math.floor(inputValue * 0.1));
  const profitNumber = document.getElementById("profit")
  const value_result = inputValue * 0.1
  profitNumber.innerHTML = (Math.floor(inputValue - value_result));
  })
});