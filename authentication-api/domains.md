## Data

1. **Users**

   - This table stores user accounts, including credentials and verification status.
   - `id` is a unique identifier for each user.
   - `email` must be unique.
   - `authentication_type` defines the login method (e.g., `PASSWORD`, `GOOGLE`).

2. **Authorization Codes**

   - Stores authorization codes for the OAuth 2.0 PKCE flow.
   - `code` is the unique authorization code.
   - `user_id` links each code to a user.
   - `expire_at` defines the code's expiration time.

3. **Sessions**
   - Manages authenticated user sessions.
   - `id` is the unique session identifier.
   - `refresh_token` is used to obtain new access tokens.
   - `user_id` links the session to a user.
   - `revoked_at` indicates if the session has been revoked.

```mermaid
erDiagram
    USERS {
        VARCHAR(26) id PK
        VARCHAR(255) email UK
        VARCHAR(255) password
        VARCHAR(25) authentication_type
        BOOLEAN is_verified
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    AUTHORIZATION_CODES {
        VARCHAR(255) code PK
        VARCHAR(255) redirect_uri
        VARCHAR(255) code_challenge
        VARCHAR(26) user_id FK
        TIMESTAMP created_at
        TIMESTAMP expire_at
    }

    SESSIONS {
        VARCHAR(26) id PK
        VARCHAR(255) refresh_token UK
        VARCHAR(26) user_id FK
        TIMESTAMP expire_at
        TIMESTAMP created_at
        TIMESTAMP revoked_at
        TIMESTAMP updated_at
    }

    USERS ||--o{ AUTHORIZATION_CODES : "issues"
    USERS ||--o{ SESSIONS : "creates"
```

---

## Users

```mermaid
---
config:
  mirrorActors: false
---
sequenceDiagram

  participant Client
  participant AuthenticationApi
  participant Database

  Client->>AuthenticationApi: Request to create

  AuthenticationApi->>Database: Search user by email

  alt User already exists
    Database-->>AuthenticationApi: Return user
    AuthenticationApi-->>Client: Return error
  else User does not exist
    Database-->>AuthenticationApi: Return null
    AuthenticationApi->>Database: Save user
    Database-->>AuthenticationApi: Return user
    AuthenticationApi-->>Client: Return success
  end

```

---

## Authorization code with PKCE

```mermaid
---
config:
  mirrorActors: false
---
sequenceDiagram

  participant Client
  participant AuthenticationApi
  participant Database

  Client->>AuthenticationApi: Authorize user

  AuthenticationApi->>Database: Search user by email

  alt User not exists
    Database-->>AuthenticationApi: Return null
    AuthenticationApi-->>Client: Return error
  else User exists
    Database-->>AuthenticationApi: Return user
    alt Invalid password
      activate AuthenticationApi
      AuthenticationApi-xAuthenticationApi: Validate password
      deactivate AuthenticationApi
      AuthenticationApi-->>Client: Return error
    else Valid password
      activate AuthenticationApi
      AuthenticationApi->>AuthenticationApi: Validate password
      deactivate AuthenticationApi
      AuthenticationApi->>Database: Save authorization code
      Database-->>AuthenticationApi: Return authorization code
      AuthenticationApi-->>Client: Return authorization code
    end
  end

```

---

## Access token request

```mermaid
---
config:
  mirrorActors: false
---
sequenceDiagram

  participant Client
  participant AuthenticationApi
  participant Database
  participant Cache

  Client->>AuthenticationApi: Request access token

  AuthenticationApi->>Database: Search authorization code

  alt Authorization code not exists
    Database-->>AuthenticationApi: Return null
    AuthenticationApi-->>Client: Return error
  else Authorization exists
    Database-->>AuthenticationApi: Return authorization code
    alt Invalid code verifier
      activate AuthenticationApi
      AuthenticationApi-xAuthenticationApi: Validate code challenge
      deactivate AuthenticationApi
      AuthenticationApi-->>Client: Return error
    else Valid code verifier
      activate AuthenticationApi
      AuthenticationApi->>AuthenticationApi: Validate code challenge
      deactivate AuthenticationApi
      activate AuthenticationApi
      AuthenticationApi->>AuthenticationApi: Issue access and refresh token
      deactivate AuthenticationApi
      AuthenticationApi->>Database: Save session
      Database-->>AuthenticationApi: Return session
      AuthenticationApi->>Cache: Save active session with ttl
      AuthenticationApi-->>Client: Return issued tokens
    end
  end

```

---

## Introspection

```mermaid
---
config:
  mirrorActors: false
---

sequenceDiagram

  participant Client
  participant AuthenticationApi
  participant Cache

  Client->>AuthenticationApi: Introspect token

  alt Expired or invalid access token
    activate AuthenticationApi
    AuthenticationApi-xAuthenticationApi: Get access token claims
    deactivate AuthenticationApi
    AuthenticationApi-->>Client: Return error
  else Valid access token
    activate AuthenticationApi
    AuthenticationApi->>AuthenticationApi: Get access token claims
    deactivate AuthenticationApi
    AuthenticationApi->>Cache: Search if session is on whitelist of activity
    Cache-->>AuthenticationApi: Return if exist or not
    AuthenticationApi-->>Client: Return introspection information
  end

```

---

## Scopes

```mermaid
---
config:
  mirrorActors: false
---

sequenceDiagram

  participant Client
  participant AuthenticationApi
  participant Database

  Client->>AuthenticationApi: Create scope

  AuthenticationApi->>Database: Search scope by name

  alt Scope already exists
    Database-->>AuthenticationApi: Return scope
    AuthenticationApi-->>Client: Return error
  else Scope not exists
    Database-->>AuthenticationApi: Return null
    AuthenticationApi->>Database: Save scope
    Database-->>AuthenticationApi: Return scope
    AuthenticationApi-->>Client: Return scope created
  end

```
