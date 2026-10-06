exports.handler = async (event, context) => {
    console.log("EVENT\n: " + JSON.stringify(event));
    return { success: true }
};