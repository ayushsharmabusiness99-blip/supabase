# Supabase Local Server

Here are the commands you need to run, manage, and use your self-hosted Supabase instance.

**Important:** You must ALWAYS run these commands from inside your `docker/` folder.

---

### Start the Server
Open a new terminal (like PowerShell) and run this to start the database, storage, and dashboard in the background:

```powershell
cd E:\codes\codes\supabase\docker
docker compose up -d
```
*Wait ~10-15 seconds for it to fully start, then you can close the terminal.*

### Stop the Server
When you are done working and want to turn the whole thing off (don't worry, data is saved!):

```powershell
cd E:\codes\codes\supabase\docker
docker compose down
```

### Check if it's running
You can see all active containers turning on with:
```powershell
cd E:\codes\codes\supabase\docker
docker ps
```

---

### Accessing your tools

Once you've run `docker compose up -d`, you can use these links:

**1. The Studio Dashboard (Visual Interface)**
- URL: [http://localhost:8000](http://localhost:8000)
- Username: `supabase`
- Password: `this_password_is_insecure_and_should_be_updated` *(defined in `docker/.env`)*

**2. Direct Database Connection (For Prisma/DBeaver/pgAdmin)**
- **Host:** `localhost`
- **Port:** `5432`
- **Database:** `postgres`
- **User:** `postgres`
- **Password:** `my_secure_personal_password_123` *(defined in `docker/.env`)*
- **Prisma Direct Link:** `postgresql://postgres:my_secure_personal_password_123@localhost:5432/postgres?schema=public`