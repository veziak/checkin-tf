[
  {
    "name": "checkin-frontend",
    "image": "${frontend_image_url}",
    "essential": true,
    "cpu": 10,
    "memory": 256,
    "links": ["checkin-backend"],
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "BACKEND_URL",
        "value": "http://checkin-backend:5000"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/checkin-frontend",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "checkin-frontend-log-stream"
      }
    }
  },
  {
    "name": "checkin-backend",
    "image": "${backend_image_url}",
    "essential": true,
    "cpu": 10,
    "memory": 256,
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000,
        "protocol": "tcp"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/checkin-backend",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "checkin-backend-log-stream"
      }
    }
  }
]