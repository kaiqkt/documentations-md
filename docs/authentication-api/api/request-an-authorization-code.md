# Request an authorization code.

This is the first step in the OAuth 2.0 Authorization Code Flow with PKCE. The client requests an authorization code by providing user credentials.

```bash
POST https://authentication-api.com/v1/oauth/authorize
```

### Request

<!-- tabs:start -->

#### **Body**

| Name             | Type     | Required | Description                                            |
| ---------------- | -------- | -------- | ------------------------------------------------------ |
| `email`          | `string` | Yes      | The user's email address.                              |
| `password`       | `string` | Yes      | The user's password.                                   |
| `redirect_uri`   | `string` | Yes      | The callback URL where the authorization code is sent. |
| `code_challenge` | `string` | Yes      | The PKCE code challenge, used to secure the flow.      |

**Example**

```json
{
  "email": "SplxlOBeZQQYbYS6WxSbIA",
  "password": "12345!@#f",
  "redirect_uri": "https://client.app/callback",
  "code_challenge": "E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM"
}
```

<!-- tabs:end -->

### Response

<!-- tabs:start -->

#### **200 OK**

Authorization code was created successfully. The code can be exchanged for an access token.

**Body Schema**

| Name             | Type     | Description                                       |
| ---------------- | -------- | ------------------------------------------------- |
| `code`           | `string` | The single-use authorization code.                |
| `redirect_uri`   | `string` | The URI to which the user will be redirected.     |
| `code_challenge` | `string` | The stored code challenge for later verification. |

**Example**

```json
{
  "code": "SplxlOBeZQQYbYS6WxSbIA",
  "redirect_uri": "https://client.app/callback",
  "code_challenge": "E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM"
}
```

#### **400 Bad Request**

The request was malformed or contained invalid arguments.

**Body Schema**

| Name     | Type     | Description                                 |
| -------- | -------- | ------------------------------------------- |
| `errors` | `object` | A map of fields to their validation errors. |

**Example**

```json
{
  "errors": {
    "email": "A valid email address is required.",
    "password": "Password must be at least 8 characters long."
  }
}
```

#### **401 Unauthorized**

The request is unauthorized, likely because the password does not matches.

**Body Schema**

| Name      | Type     | Description        |
| --------- | -------- | ------------------ |
| `type`    | `string` | The error type.    |
| `message` | `string` | The error message. |

**Example**

```json
{
  "type": "INVALID_PASSWORD",
  "message": "Invalid password"
}
```

#### **404 Not Found**

The request is not found because user not exists.

**Body Schema**

| Name      | Type     | Description        |
| --------- | -------- | ------------------ |
| `type`    | `string` | The error type.    |
| `message` | `string` | The error message. |

**Example**

```json
{
  "type": "USER_NOT_FOUND",
  "message": "User not found"
}
```

<!-- tabs:end -->
