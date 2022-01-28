let _addToCart = document.getElementsByClassName("btn-addToCart")
let productCard = []

for(let i = 0; i < _addToCart.length; i++) {
    _addToCart[i].addEventListener("click", addToCart)
}
function addToCart(event){
    //let _mainContainer = document.getElementsById("cart-container")[0]
    let _btn = event.target
    let _btnParent = _btn.parentElement
    let _btnGrandParent = _btn.parentElement.parentElement
    let _itemName = _btnParent.children[1].innerText
    let _itemPrice = _btnParent.children[2].innerText
    let _select = document.getElementById("Color")
    let _itemColor = _select.options[_select.selectedIndex].value
    let _itemImage = _btnGrandParent.children[0].children[0].src
    let _quantity = document.getElementById("Quantity").value
    let itemPriceN = _itemPrice.replace(/\D/g, "")
    let _subtotal = _quantity * itemPriceN
    
    productCard.push({_itemImage, _itemName, _itemColor, _itemPrice, _subtotal})
    
}

console.log(productCard)
