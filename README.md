### Start services

```shell
$ docker-compose up
```

## Kafka Connect Rest API
https://docs.confluent.io/platform/current/connect/references/restapi.html#kconnect-rest-interface

### Start JDBC Sink Connector (Postgre Target Table MOVIE)
```shell
$ curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://127.0.0.1:8083/connectors/ -d @jdbc-sink-table-movie.json
```

### Start JDBC Sink Connector (Postgre Target Table PERSON)
```shell
$ curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://127.0.0.1:8083/connectors/ -d @jdbc-sink-table-person.json
```

### Start Debezium PostgreSQL CDC connector (PostgreSQL Source)

```shell
$ curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://127.0.0.1:8083/connectors/ -d @postgre-source.json
```

### Insert or update example data to PostgreSQL
```
debeziumtest=# INSERT INTO MOVIE(TITLE, DESCRIPTION) VALUES('Spiderman 2', 'good');

debeziumtest=# INSERT INTO MOVIE(TITLE, DESCRIPTION) VALUES('Spiderman 3', 'good');
```

### Now, the data in the Postgres database should also change
```shell
debeziumtest=# SELECT * FROM "public"."dbpostgresqlserver1_publicmovie;";
 DESCRIPTION |      created_at      |                   TITLE                    | ID 
-------------+----------------------+--------------------------------------------+----
 good        | 2023-03-06T14:11:18Z | Spiderman 2                                | 1
 good        | 2023-03-06T15:32:54Z | Spiderman 3                                | 2
(2 rows)
```

#### Kafka CLI

List `topic`
```shell
$ /bin/kafka-topics.sh --zookeeper zookeeper:2181 --list
```

Subscribe to `topic`
```shell
$ /bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topic-name --from-beginning
```

#### Reference
- https://debezium.io/documentation/reference/stable/connectors/postgresql.html#setting-up-postgresql