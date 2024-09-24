# tests/test_routes.py

from app import app

def test_index_route():
    client = app.test_client()
    response = client.get('/')
    assert response.status_code == 200
    

def test_template_rendering():
    client = app.test_client()
    response = client.get('/')
    assert b"Hello From Travos lab" in response.data



        