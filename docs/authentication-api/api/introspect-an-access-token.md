# Introspect an Access Token

This endpoint checks the validity of an access token and returns its metadata.

### Endpoint

```bash
GET https://authentication-api.com/v1/oauth/introspect
```

### Headers

<!-- tabs:start -->

#### **Headers**

| Name            | Type     | Required | Description                                              |
| --------------- | -------- | -------- | -------------------------------------------------------- |
| `Authorization` | `string` | Yes      | The access token to introspect, prefixed with `Bearer `. |

<!-- tabs:end -->

### Possible Responses

<!-- tabs:start -->

#### **200 OK**

The token is valid and active. The response contains the token's metadata.

**Body Schema**

| Name     | Type      | Description                                 |
| -------- | --------- | ------------------------------------------- |
| `active` | `boolean` | Indicates whether the token is active.      |
| `sid`    | `string`  | The session identifier.                     |
| `sub`    | `string`  | The subject of the token (usually user ID). |
| `scope`  | `string`  | A space-separated list of scopes.           |
| `iss`    | `string`  | The token issuer.                           |
| `exp`    | `integer` | The token expiration timestamp (Unix time). |
| `iat`    | `integer` | The token issuance timestamp (Unix time).   |

**Example**

```json
{
  "active": true,
  "sid": "s_12345",
  "sub": "u_abcde",
  "scope": "read:profile",
  "iss": "https://auth.example.com",
  "exp": 1678886400,
  "iat": 1678882800
}
```

#### **401 Unauthorized**

The request is unauthorized, likely because the token is invalid, expired, or not provided.

**Body Schema**

| Name      | Type     | Description                                        |
| --------- | -------- | -------------------------------------------------- |
| `type`    | `string` | The error type (`TOKEN_INVALID`, `TOKEN_EXPIRED`). |
| `message` | `string` | The error message.                                 |

**Example**

```json
{
  "type": "TOKEN_INVALID",
  "message": "Token is invalid or expired."
}
```

<!-- tabs:end -->
