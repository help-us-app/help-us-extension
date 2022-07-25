function parseItem(title, price, quantity, product_link, product_image) {
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
        if (request.query === "get_html") {
            sendResponse('<html>' + document.documentElement.innerHTML + '</html>');
        }
    }
);
