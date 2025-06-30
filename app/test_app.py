import pytest
from app import app, todos


@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client


@pytest.fixture(autouse=True)
def clear_todos():
    """Ensure test isolation by resetting todos before each test."""
    todos.clear()


def test_index_get(client):
    response = client.get("/")
    assert response.status_code == 200
    assert b"No custom message set." in response.data or b"custom_message" in response.data


def test_add_todo_post(client):
    response = client.post("/", data={"todo": "Write tests"}, follow_redirects=True)
    assert response.status_code == 200
    assert b"Write tests" in response.data
    assert "Write tests" in todos


def test_add_empty_todo(client):
    response = client.post("/", data={"todo": ""}, follow_redirects=True)
    assert response.status_code == 200
    assert len(todos) == 0  # Should not append empty item


def test_delete_valid_index(client):
    todos.extend(["Task 1", "Task 2", "Task 3"])
    response = client.get("/delete/1", follow_redirects=True)
    assert response.status_code == 200
    assert "Task 2" not in todos
    assert len(todos) == 2


def test_delete_invalid_index(client):
    todos.extend(["Only Task"])
    response = client.get("/delete/5", follow_redirects=True)
    assert response.status_code == 200
    assert len(todos) == 1  # Nothing should be deleted
