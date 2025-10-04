# Revoke a User Session

This endpoint invalidates a specific user session, effectively logging the user out from that session.

### Endpoint

```bash
DELETE https://authentication-api.com/v1/session/{session_id}
```

### Parameters

<!-- tabs:start -->

#### **Path Parameters**

| Name         | Type     | Required | Description                      |
| ------------ | -------- | -------- | -------------------------------- |
| `session_id` | `string` | Yes      | The ID of the session to revoke. |

#### **Headers**

| Name            | Type     | Required | Description                                 |
| --------------- | -------- | -------- | ------------------------------------------- |
| `X-User-Id`     | `string` | Yes      | The ID of the user owning the session.      |
| `Authorization` | `string` | Yes      | User access token, prefixed with `Bearer `. |

<!-- tabs:end -->

### Possible Responses

<!-- tabs:start -->

#### **204 No Content**

The session was revoked successfully. No content is returned.

#### **401 Unauthorized**

The request is unauthorized, likely due to a missing, invalid, or expired access token.

**Body Schema**

| Name      | Type     | Description                                        |
| --------- | -------- | -------------------------------------------------- |
| `type`    | `string` | The error type (`TOKEN_INVALID`, `TOKEN_EXPIRED`). |
| `message` | `string` | The error message.                                 |

**Example**

```json
{
  "type": "TOKEN_EXPIRED",
  "message": "Invalid token."
}
```

<!-- tabs:end -->
