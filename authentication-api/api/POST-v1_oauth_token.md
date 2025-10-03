# POST /v1/oauth/token

Request an access token.

This endpoint exchanges an authorization code or a refresh token for a new access token.

### cURL

```bash
# Using Authorization Code
curl -X POST "$BASE_URL/v1/oauth/token" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{ "grant_type": "authorization_code", "code": "SplxlOBeZQQYbYS6WxSbIA", "redirect_uri": "https://client.app/callback", "code_verifier": "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk" }'

# Using Refresh Token
curl -X POST "$BASE_URL/v1/oauth/token" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{ "grant_type": "refresh_token", "refresh_token": "def50200f492..." }'
```

### Request Body

| Name            | Type     | Required | Description                                                                 |
|-----------------|----------|----------|-----------------------------------------------------------------------------|
| `grant_type`    | `string` | Yes      | The grant type. Must be `authorization_code` or `refresh_token`.            |
| `code`          | `string` | No       | The authorization code (required if `grant_type` is `authorization_code`).   |
| `code_verifier` | `string` | No       | The PKCE code verifier (required if `grant_type` is `authorization_code`).   |
| `refresh_token` | `string` | No       | The refresh token (required if `grant_type` is `refresh_token`).             |
| `redirect_uri`  | `string` | No       | The original redirect URI (required if `grant_type` is `authorization_code`). |

### Responses

<!-- tabs:start -->

#### **200 OK**

Access token was created successfully.

**Body Schema**

| Name            | Type      | Description                                      |
|-----------------|-----------|--------------------------------------------------|
| `access_token`  | `string`  | The access token for making authenticated requests. |
| `refresh_token` | `string`  | The token used to obtain a new access token.     |
| `token_type`    | `string`  | The type of token (always `Bearer`).             |
| `expires_in`    | `integer` | The lifetime of the access token in seconds.     |

**Example**

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "def50200f492...",
  "token_type": "Bearer",
  "expires_in": 3600
}
```

#### **400 Bad Request**

The request was malformed, such as having an invalid grant type or a missing required parameter.

**Body Schema**

| Name     | Type     | Description                               | 
|----------|----------|-------------------------------------------|
| `errors` | `object` | A map of fields to their validation errors. |

**Example**

```json
{
  "errors": {
    "grantType": "Unsupported grant type."
  }
}
```

#### **401 Unauthorized**

The authorization code, refresh token, or other credential is invalid or expired.

**Body Schema**

| Name      | Type     | Description      |
|-----------|----------|------------------|
| `type`    | `string` | The error type.  |
| `message` | `string` | The error message. |

**Example**

```json
{
  "type": "unauthorized",
  "message": "The authorization code is invalid or has expired."
}
```

<!-- tabs:end -->
