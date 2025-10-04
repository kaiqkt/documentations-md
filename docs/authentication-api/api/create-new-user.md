# Create a New User

This endpoint registers a new user in the system with the provided email and password.

### Endpoint

```bash
POST https://authentication-api.com/v1/user
```

### Body

<!-- tabs:start -->

#### **Body**

| Name       | Type     | Required | Description                                              |
| ---------- | -------- | -------- | -------------------------------------------------------- |
| `email`    | `string` | Yes      | The user's unique email address.                         |
| `password` | `string` | Yes      | The user's password (must meet complexity requirements). |

**Example**

```json
{
  "email": "new.user@example.com",
  "password": "a-very-strong-password"
}
```

<!-- tabs:end -->

### Possible Responses

<!-- tabs:start -->

#### **201 Created**

The user was created successfully. The response contains basic information about the new user.

**Body Schema**

| Name                  | Type      | Description                                                |
| --------------------- | --------- | ---------------------------------------------------------- |
| `email`               | `string`  | The email address of the created user.                     |
| `is_verified`         | `boolean` | Indicates if the user's email has been verified.           |
| `authentication_type` | `string`  | The authentication method for the user (e.g., `STANDARD`). |

**Example**

```json
{
  "email": "new.user@example.com",
  "is_verified": false,
  "authentication_type": "STANDARD"
}
```

#### **400 Bad Request**

The request was malformed, such as providing an invalid email format or a weak password.

**Body Schema**

| Name     | Type     | Description                                 |
| -------- | -------- | ------------------------------------------- |
| `errors` | `object` | A map of fields to their validation errors. |

**Example**

```json
{
  "errors": {
    "password": "Password is too weak."
  }
}
```

#### **409 Conflict**

A user with the provided email address already exists.

**Body Schema**

| Name      | Type     | Description        |
| --------- | -------- | ------------------ |
| `type`    | `string` | The error type.    |
| `message` | `string` | The error message. |

**Example**

```json
{
  "type": "conflict",
  "message": "A user with this email already exists."
}
```

<!-- tabs:end -->
