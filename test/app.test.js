const request = require('supertest');
const app = require('../app');

describe('API Endpoints', () => {
  describe('GET /', () => {
    it('should return welcome message', async () => {
      const res = await request(app)
        .get('/')
        .expect(200);
      
      expect(res.body).toHaveProperty('message');
      expect(res.body).toHaveProperty('timestamp');
      expect(res.body).toHaveProperty('version');
      expect(res.body.message).toBe('Welcome to MERN CI/CD Pipeline Demo!');
    });
  });

  describe('GET /api/health', () => {
    it('should return health status', async () => {
      const res = await request(app)
        .get('/api/health')
        .expect(200);
      
      expect(res.body).toHaveProperty('status');
      expect(res.body).toHaveProperty('uptime');
      expect(res.body).toHaveProperty('timestamp');
      expect(res.body.status).toBe('healthy');
    });
  });

  describe('GET /api/users', () => {
    it('should return users list', async () => {
      const res = await request(app)
        .get('/api/users')
        .expect(200);
      
      expect(res.body).toHaveProperty('users');
      expect(res.body).toHaveProperty('count');
      expect(Array.isArray(res.body.users)).toBe(true);
      expect(res.body.count).toBe(3);
      expect(res.body.users[0]).toHaveProperty('id');
      expect(res.body.users[0]).toHaveProperty('name');
      expect(res.body.users[0]).toHaveProperty('email');
    });
  });

  describe('GET /nonexistent', () => {
    it('should return 404 for non-existent routes', async () => {
      const res = await request(app)
        .get('/nonexistent')
        .expect(404);
      
      expect(res.body).toHaveProperty('error');
      expect(res.body.error).toBe('Route not found');
    });
  });
});