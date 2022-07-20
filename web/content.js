function parseItem(title, price, quantity, product_link, product_image) {
    price = price.replace('$', '');
    return JSON.stringify({
        title: title,
        price: price,
        quantity: quantity,
        product_link: product_link,
        product_image: product_image
    });
}

chrome.runtime.onMessage.addListener(
    function (request, sender, sendResponse) {
        if (request.query === "amazon") {
            const items = document.getElementsByClassName("sc-list-item-content");

            const list = [];
            for (let i = 0; i < items.length; i++) {
                const title = items[i].getElementsByClassName("sc-product-title")[0];
                const price = items[i].getElementsByClassName("sc-price")[0];
                const quantity = items[i].getElementsByClassName("a-dropdown-prompt")[0];
                const product_link = items[i].getElementsByClassName("sc-product-link")[0];
                const product_image = items[i].getElementsByClassName("sc-product-image")[0];

                list.push(parseItem(title.innerText, price.innerText, quantity.innerText, product_link.href, product_image.src));
            }
            sendResponse({result: list});
        }
    }
);
