import pytest

from main import app


@pytest.fixture
def client():
    """Creates a test client for the Flask app."""
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client


def test_home_route(client):
    """Tests the home route ('/')."""
    response = client.get("/")
    assert response.status_code == 200
    assert b"Hello from Flask!" in response.data


def test_greet_route_default(client):
    """Tests the greet route ('/greet') with default name."""
    response = client.get("/greet")
    assert response.status_code == 200
    assert response.get_json() == {"message": "Hello, World!"}


def test_greet_route_with_name(client):
    """Tests the greet route ('/greet') with a specific name."""
    response = client.get("/greet?name=Alice")
    assert response.status_code == 200
    assert response.get_json() == {"message": "Hello, Alice!"}
