## Table schema

### `User` model
- id
- email: string
- name: string
- password_digest: string

### `Task` model
- id
- user_id
- label_id
- title: string
- description: text
- due_date: date
- priority: integer
- status: string

## `Label` model
- id
- task_id
- label_name: string
