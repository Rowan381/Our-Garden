const axios = require("axios").default;
const qs = require("qs");

/// Start Stripe Group Code

function createStripeGroup() {
  return {
    baseUrl: `https://api.stripe.com/v1`,
    headers: {
      Authorization: `Bearer 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`,
      "Content-Type": `application/x-www-form-urlencoded`,
    },
  };
}

async function _retrieveAccountInfoCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var accountID = ffVariables["accountID"];
  const stripeGroup = createStripeGroup();

  var url = `${stripeGroup.baseUrl}/accounts/${accountID}`;
  var headers = {
    Authorization: `Bearer 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`,
    "Content-Type": `application/x-www-form-urlencoded`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}

async function _retrieveSessionCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var sessionID = ffVariables["sessionID"];
  const stripeGroup = createStripeGroup();

  var url = `${stripeGroup.baseUrl}/checkout/sessions/${sessionID}`;
  var headers = {
    Authorization: `Bearer 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`,
    "Content-Type": `application/x-www-form-urlencoded`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}

async function _accountsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var businessType = ffVariables["businessType"];
  var type = ffVariables["type"];
  var country = ffVariables["country"];
  var email = ffVariables["email"];
  const stripeGroup = createStripeGroup();

  var url = `${stripeGroup.baseUrl}/accounts`;
  var headers = {
    Authorization: `Bearer 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`,
    "Content-Type": `application/x-www-form-urlencoded`,
  };
  var params = {
    business_type: businessType,
    type: type,
    country: country,
    email: email,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "X_WWW_FORM_URL_ENCODED",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}

async function _createAccountLinkCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var account = ffVariables["account"];
  var type = ffVariables["type"];
  var refreshUrl = ffVariables["refreshUrl"];
  var returnUrl = ffVariables["returnUrl"];
  const stripeGroup = createStripeGroup();

  var url = `${stripeGroup.baseUrl}/account_links`;
  var headers = {
    Authorization: `Bearer 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`,
    "Content-Type": `application/x-www-form-urlencoded`,
  };
  var params = {
    account: account,
    type: type,
    refresh_url: refreshUrl,
    return_url: returnUrl,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "X_WWW_FORM_URL_ENCODED",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}

async function _sessionsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var connectedAcct = ffVariables["connectedAcct"];
  var cancelURL = ffVariables["cancelURL"];
  var successURL = ffVariables["successURL"];
  var currency = ffVariables["currency"];
  var productName = ffVariables["productName"];
  var pricePerUnit = ffVariables["pricePerUnit"];
  var quantity = ffVariables["quantity"];
  var stripeFee = ffVariables["stripeFee"];
  const stripeGroup = createStripeGroup();

  var url = `${stripeGroup.baseUrl}/checkout/sessions`;
  var headers = {
    Authorization: `Bearer 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`,
    "Content-Type": `application/x-www-form-urlencoded`,
  };
  var params = {
    cancel_url: cancelURL,
    success_url: successURL,
    "line_items[0][price_data][currency]": currency,
    "line_items[0][price_data][product_data][name]": productName,
    "line_items[0][price_data][unit_amount]": pricePerUnit,
    "line_items[0][quantity]": quantity,
    mode: `payment`,
    "line_items[1][price_data][currency]": currency,
    "line_items[1][price_data][product_data][name]": `Stripe Fee`,
    "line_items[1][price_data][unit_amount]": stripeFee,
    "line_items[1][quantity]": 1,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "X_WWW_FORM_URL_ENCODED",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}

/// End Stripe Group Code

/// Start KindWiseAPI Group Code

function createKindWiseAPIGroup(key) {
  return {
    baseUrl: `https://plant.id/api/v3`,
    headers: { "Api-Key": `[key]` },
  };
}

async function _threadkindwiseCall(context, ffVariables) {
  var key = ffVariables["key"];
  const kindWiseAPIGroup = createKindWiseAPIGroup(key);

  var url = `${kindWiseAPIGroup.baseUrl}/threads`;
  var headers = { "Api-Key": `${key}` };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}

async function _retrieveIDCall(context, ffVariables) {
  var accessToken = ffVariables["accessToken"];
  var key = ffVariables["key"];
  const kindWiseAPIGroup = createKindWiseAPIGroup(key);

  var url = `${kindWiseAPIGroup.baseUrl}/identification/${accessToken}`;
  var headers = { "Api-Key": `${key}` };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}

async function _messageskindwiseCall(context, ffVariables) {
  var key = ffVariables["key"];
  const kindWiseAPIGroup = createKindWiseAPIGroup(key);

  var url = `${kindWiseAPIGroup.baseUrl}messages`;
  var headers = { "Api-Key": `${key}` };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}

async function _plantIDCall(context, ffVariables) {
  var images = ffVariables["images"];
  var health = ffVariables["health"];
  var key = ffVariables["key"];
  const kindWiseAPIGroup = createKindWiseAPIGroup(key);

  var url = `${kindWiseAPIGroup.baseUrl}/identification`;
  var headers = { "Api-Key": `${key}` };
  var params = {};
  var ffApiRequestBody = `
{
  "images": ${images},
  "health": "${escapeStringForJson(health)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}

/// End KindWiseAPI Group Code

/// Start OpenAI ChatGPT Group Code

function createOpenAIChatGPTGroup() {
  return {
    baseUrl: `https://api.openai.com/v1`,
    headers: {
      bearer: `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`,
      "OpenAI-Beta": `assistants=v2`,
    },
  };
}

async function _runCall(context, ffVariables) {
  var threadId = ffVariables["threadId"];
  var assistantId = ffVariables["assistantId"];
  var additionalInstructions = ffVariables["additionalInstructions"];
  const openAIChatGPTGroup = createOpenAIChatGPTGroup();

  var url = `${openAIChatGPTGroup.baseUrl}/threads/${threadId}/runs`;
  var headers = {
    bearer: `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`,
    "OpenAI-Beta": `assistants=v2`,
    Authorization: `bearer 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`,
    "Content-Type": `Application/Json`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "assistant_id": "${assistantId}",
  "additional_instructions": "${additionalInstructions}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}

async function _retrieverunCall(context, ffVariables) {
  var threadId = ffVariables["threadId"];
  var runId = ffVariables["runId"];
  const openAIChatGPTGroup = createOpenAIChatGPTGroup();

  var url = `${openAIChatGPTGroup.baseUrl}/threads/${threadId}/runs/${runId}`;
  var headers = {
    bearer: `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`,
    "OpenAI-Beta": `assistants=v2`,
    Authorization: `bearer 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`,
    "Content-Type": `application/json`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}

async function _messageCall(context, ffVariables) {
  var threadId = ffVariables["threadId"];
  var content = ffVariables["content"];
  const openAIChatGPTGroup = createOpenAIChatGPTGroup();

  var url = `${openAIChatGPTGroup.baseUrl}/threads/${threadId}/messages`;
  var headers = {
    bearer: `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`,
    "OpenAI-Beta": `assistants=v2`,
    Authorization: `Bearer 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`,
    "Content-Type": `Application/Json`,
    "OpenAI-Beta": `assistants=v2`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "role": "user",
  "content": "[[${content}]]"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}

async function _threadsCall(context, ffVariables) {
  var token = ffVariables["token"];
  const openAIChatGPTGroup = createOpenAIChatGPTGroup();

  var url = `${openAIChatGPTGroup.baseUrl}/threads`;
  var headers = {
    bearer: `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`,
    "OpenAI-Beta": `assistants=v2`,
    Authorization: `Bearer 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`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}

async function _messagesCall(context, ffVariables) {
  var threadId = ffVariables["threadId"];
  const openAIChatGPTGroup = createOpenAIChatGPTGroup();

  var url = `${openAIChatGPTGroup.baseUrl}/threads/${threadId}/messages`;
  var headers = {
    bearer: `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`,
    "OpenAI-Beta": `assistants=v2`,
    Authorization: `bearer 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`,
    "Content-Type": `Application/Json`,
  };
  var params = { limit: 1 };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}

/// End OpenAI ChatGPT Group Code

async function _stripeTroubleshootCall(context, ffVariables) {
  var email = ffVariables["email"];

  var url = `https://api.stripe.com/v1/accounts`;
  var headers = {
    "Content-Type": `application/JSON`,
    Authorization: `Bearer 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`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "email": "${escapeStringForJson(email)}",
  "type": "express",
  "business_type": "individual",
  "country": "us"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}

/// Helper functions to route to the appropriate API Call.

async function makeApiCall(context, data) {
  var callName = data["callName"] || "";
  var variables = data["variables"] || {};

  const callMap = {
    StripeTroubleshootCall: _stripeTroubleshootCall,
    RetrieveAccountInfoCall: _retrieveAccountInfoCall,
    RetrieveSessionCall: _retrieveSessionCall,
    AccountsCall: _accountsCall,
    CreateAccountLinkCall: _createAccountLinkCall,
    SessionsCall: _sessionsCall,
    ThreadkindwiseCall: _threadkindwiseCall,
    RetrieveIDCall: _retrieveIDCall,
    MessageskindwiseCall: _messageskindwiseCall,
    PlantIDCall: _plantIDCall,
    RunCall: _runCall,
    RetrieverunCall: _retrieverunCall,
    MessageCall: _messageCall,
    ThreadsCall: _threadsCall,
    MessagesCall: _messagesCall,
  };

  if (!(callName in callMap)) {
    return {
      statusCode: 400,
      error: `API Call "${callName}" not defined as private API.`,
    };
  }

  var apiCall = callMap[callName];
  var response = await apiCall(context, variables);
  return response;
}

async function makeApiRequest({
  method,
  url,
  headers,
  params,
  body,
  returnBody,
  isStreamingApi,
}) {
  return axios
    .request({
      method: method,
      url: url,
      headers: headers,
      params: params,
      responseType: isStreamingApi ? "stream" : "json",
      ...(body && { data: body }),
    })
    .then((response) => {
      return {
        statusCode: response.status,
        headers: response.headers,
        ...(returnBody && { body: response.data }),
        isStreamingApi: isStreamingApi,
      };
    })
    .catch(function (error) {
      return {
        statusCode: error.response.status,
        headers: error.response.headers,
        ...(returnBody && { body: error.response.data }),
        error: error.message,
      };
    });
}

const _unauthenticatedResponse = {
  statusCode: 401,
  headers: {},
  error: "API call requires authentication",
};

function createBody({ headers, params, body, bodyType }) {
  switch (bodyType) {
    case "JSON":
      headers["Content-Type"] = "application/json";
      return body;
    case "TEXT":
      headers["Content-Type"] = "text/plain";
      return body;
    case "X_WWW_FORM_URL_ENCODED":
      headers["Content-Type"] = "application/x-www-form-urlencoded";
      return qs.stringify(params);
  }
}
function escapeStringForJson(val) {
  if (typeof val !== "string") {
    return val;
  }
  return val
    .replace(/[\\]/g, "\\\\")
    .replace(/["]/g, '\\"')
    .replace(/[\n]/g, "\\n")
    .replace(/[\t]/g, "\\t");
}

module.exports = { makeApiCall };
