# County Director of Education - Appointment Booking System

A modern, secure, and user-friendly appointment management system for the County Director of Education (CDE) Office.

## 🎯 Overview

This full-stack application enables schools, teachers, parents, education officers, and members of the public to book appointments online with the County Director. The system includes:

- **Online Appointment Booking** - Intuitive booking interface for different user types
- **Smart Availability Management** - Prevent double bookings and manage officer availability
- **Director Approval Workflow** - Email/SMS notifications to director for confirmation
- **Visitor Management** - Complete visitor record keeping with check-in/check-out
- **Advanced Reporting** - Generate reports by department, officer, institution, and purpose
- **Role-Based Access Control** - Separate dashboards for admins, officers, receptionists, and visitors
- **Mobile Responsive** - Works seamlessly on desktop and mobile devices
- **Secure Infrastructure** - JWT authentication, encrypted data, audit logs

## 🏗️ Technology Stack

### Backend
- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: PostgreSQL
- **Authentication**: JWT (JSON Web Tokens)
- **Email**: Nodemailer
- **SMS**: Twilio
- **Validation**: Joi
- **Logging**: Winston

### Frontend
- **Framework**: React 18+
- **State Management**: Redux Toolkit
- **Styling**: Tailwind CSS / Material-UI
- **Calendar**: React Big Calendar
- **Charts**: Recharts
- **Export**: xlsx, jspdf

## 📂 Project Structure

```
appointment-booking-system/
├── backend/                  # Node.js/Express API
│   ├── src/
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── middleware/
│   │   ├── services/
│   │   ├── utils/
│   │   └── migrations/
│   └── server.js
├── frontend/                 # React application
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── services/
│   │   ├── store/
│   │   └── styles/
│   └── public/
├── database/                 # Database setup
│   └── schema.sql
└── docker-compose.yml
```

## 🚀 Quick Start

### Prerequisites
- Node.js 16+
- PostgreSQL 12+

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/hackwan/appointment-booking-system.git
cd appointment-booking-system
```

2. **Install dependencies**
```bash
cd backend && npm install
cd ../frontend && npm install
```

3. **Setup environment variables**
```bash
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env
```

4. **Setup database**
```bash
cd backend && npm run migrate
```

5. **Start the application**
```bash
# Terminal 1 - Backend
cd backend && npm run dev

# Terminal 2 - Frontend
cd frontend && npm start
```

## 📋 User Roles

- **County Director** - Approve/reject appointments, view reports
- **Education Officers** - Manage personal appointments and availability
- **Receptionist** - Check-in/check-out visitors, manage records
- **Schools/Teachers** - Book and manage appointments
- **Public Visitors** - Book appointments and receive confirmations

## 🔐 Security Features

- JWT-based authentication
- Role-based access control (RBAC)
- Password encryption (bcrypt)
- Secure API endpoints
- Audit logging
- Rate limiting
- CORS protection

## 📊 Key Features

✅ Online appointment booking
✅ Double booking prevention
✅ Email & SMS notifications
✅ Visitor check-in/check-out
✅ Report generation & export
✅ Calendar integration
✅ Mobile responsive design
✅ Audit logs

## 📝 License

MIT License - see LICENSE file for details
