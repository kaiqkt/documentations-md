## Data Model

1. **Users**

   - This table stores user accounts, including credentials and verification status.
   - `id` is a unique identifier for each user.
   - `email` must be unique.
   - `password` must be in hash format.
   - `authentication_type` defines the login method (e.g., `PASSWORD`, `GOOGLE`).

2. **Sessions**
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

    SESSIONS {
        VARCHAR(26) id PK
        VARCHAR(255) refresh_token UK
        VARCHAR(26) user_id FK
        TIMESTAMP expire_at
        TIMESTAMP created_at
        TIMESTAMP revoked_at
        TIMESTAMP updated_at
    }

    USERS ||--o{ SESSIONS : "creates"
```

---
