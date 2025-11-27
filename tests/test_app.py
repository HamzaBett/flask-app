import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home_route(client):
    """Test the home route returns expected JSON response"""
    rv = client.get('/')
    json_data = rv.get_json()
    
    assert rv.status_code == 200
    assert json_data['status'] == 'success'
    assert 'Flask app is running!' in json_data['message']
    assert 'version' in json_data

def test_health_route(client):
    """Test the health check route"""
    rv = client.get('/health')
    json_data = rv.get_json()
    
    assert rv.status_code == 200
    assert json_data['status'] == 'healthy'
