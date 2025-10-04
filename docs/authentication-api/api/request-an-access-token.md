# Request an Access Token

This endpoint exchanges a refresh token for a new access token.

```bash
POST https://authentication-api.com/v1/oauth/token
```

### Body

<!-- tabs:start -->

#### **Body**

| Name            | Type     | Required | Description                                                                    |
| --------------- | -------- | -------- | ------------------------------------------------------------------------------ |
| `grant_type`    | `string` | Yes      | The grant type. Must be `refresh_token`.                                       |
| `refresh_token` | `string` | No       | The refresh token (required if `grant_type` is `refresh_token` or `password`). |
| `email`         | `string` | No       | User registered email.                                                         |
| `password`      | `string` | No       | User registered password.                                                      |

**Example for Refresh Token**

```json
{
  "grant_type": "refresh_token",
  "refresh_token": "def50200f492..."
}
```

**Example for Password**

```json
{
  "email": "kt@kt.com",
  "password": "strong-password"
}
```

<!-- tabs:end -->

### Possible Responses

<!-- tabs:start -->

#### **200 OK**

The access token was created successfully.

**Body Schema**

| Name            | Type      | Description                                         |
| --------------- | --------- | --------------------------------------------------- |
| `access_token`  | `string`  | The access token for making authenticated requests. |
| `refresh_token` | `string`  | The token used to obtain a new access token.        |
| `token_type`    | `string`  | The type of token (always `Bearer`).                |
| `expires_in`    | `integer` | The lifetime of the access token in seconds.        |

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

| Name     | Type     | Description                                 |
| -------- | -------- | ------------------------------------------- |
| `errors` | `object` | A map of fields to their validation errors. |

**Example**

```json
{
  "errors": {
    "grantType": "Unsupported grant type."
  }
}
```

#### **401 Not Found**

Invalid credentials.

**Body Schema**

| Name      | Type     | Description        |
| --------- | -------- | ------------------ |
| `type`    | `string` | The error type.    |
| `message` | `string` | The error message. |

**Example**

```json
{
  "type": "unathorized",
  "message": "unathorized"
}
```

#### **404 Not Found**

The session or user does not exist.

**Body Schema**

| Name      | Type     | Description        |
| --------- | -------- | ------------------ |
| `type`    | `string` | The error type.    |
| `message` | `string` | The error message. |

**Example**

```json
{
  "type": "not_found",
  "message": "not found."
}
```

<!-- tabs:end -->
