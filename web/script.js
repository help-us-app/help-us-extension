async function sendCommand(qry) {
    let queryOptions = {active: true, currentWindow: true};
    let [tab] = await chrome.tabs.query(queryOptions);
    let message = {query: qry, id: tab.id};
    let response = await chrome.tabs.sendMessage(tab.id, message);
    return response;
}

async function getHtml() {
    return await sendCommand("get_html");
}

async function getUrl() {
    let queryOptions = {active: true, currentWindow: true};
    const tabs = await chrome.tabs.query(queryOptions)
    return tabs[0].url;
}