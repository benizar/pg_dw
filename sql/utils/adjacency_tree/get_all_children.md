
--https://wiki.postgresql.org/wiki/Getting_list_of_all_children_from_adjacency_tree

## Description

Assuming you have Adjacency List based tree - i.e. table with structure similar to this:

                           Table "public.test"
  Column   |  Type   |                     Modifiers
-----------+---------+---------------------------------------------------
 id        | integer | not null default nextval('test_id_seq'::regclass)
 parent_id | integer |
 x         | text    |
Indexes:
    "test_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "test_parent_id_fkey" FOREIGN KEY (parent_id) REFERENCES test(id)

you might want to get all children of given element.

To do it, you can use this function:

```sql
CREATE OR REPLACE FUNCTION get_all_children_array(use_parent INT4) RETURNS INT4[] AS $$
DECLARE
    process_parents INT4[] := ARRAY[ use_parent ];
    children INT4[] := '{}';
    new_children INT4[];
BEGIN
    WHILE ( array_upper( process_parents, 1 ) IS NOT NULL ) LOOP
        new_children := ARRAY( SELECT id FROM test WHERE parent_id = ANY( process_parents ) AND id <> ALL( children ) );
        children := children || new_children;
        process_parents := new_children;
    END LOOP;
    RETURN children;
END;
$$ LANGUAGE plpgsql;
```


Usage:
```sql
SELECT get_all_children_array(3);
```
 
get_all_children_array
------------------------
 {5,6,9}
(1 ROW)
 
```sql 
SELECT * FROM test WHERE id = any( get_all_children_array(3) );
```

 id | parent_id | x
----+-----------+---
  5 |         3 | e
  6 |         3 | f
  9 |         5 | i
(3 ROWS)


## PostgreSQL 8.4+

Common Table Expressions (CTE) make it much easier to write this as a query instead of as a procedure:

First, we write the CTE to return all ancestors of the item:

```sql
WITH RECURSIVE tree AS (
  SELECT id, ARRAY[]::INTEGER[] AS ancestors
  FROM test WHERE parent_id IS NULL
 
  UNION ALL
 
  SELECT test.id, tree.ancestors || test.parent_id
  FROM test, tree
  WHERE test.parent_id = tree.id
) SELECT * FROM tree WHERE 0 = ANY(tree.ancestors);
```

This query could return something like this:

 id | ancestors
------------------------
  3 | {}
  5 | {3}
  6 | {3}
  9 | {3,5}
(4 rows)

Now that we have an array of ancestors for each item, retrieving the descendants is a simple WHERE clause:

```sql
WITH RECURSIVE tree AS (
  SELECT id, ARRAY[]::INTEGER[] AS ancestors
  FROM test WHERE parent_id IS NULL
 
  UNION ALL
 
  SELECT test.id, tree.ancestors || test.parent_id
  FROM test, tree
  WHERE test.parent_id = tree.id
) SELECT * FROM tree WHERE 3 = ANY(tree.ancestors);
```

Given the result above, this query would return the following:

 id | ancestors
------------------------
  5 | {3}
  6 | {3}
  9 | {3,5}
(3 rows)




