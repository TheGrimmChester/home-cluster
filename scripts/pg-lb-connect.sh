kubectl port-forward --namespace default svc/postgres-lb 5433:5432
PGPASSWORD="XXXX" psql --host 127.0.0.1 -U postgres -d postgres -p 5433
PGPASSWORD="TxVeQ4nN82SSiYHoswqOURZvQDaL4KpNElsCEEe9bwDxMd73KckIeXzS5cU6LiC2" psql --host 127.0.0.1 -U app -d app -p 5433
