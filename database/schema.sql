-- Create ENUM types
CREATE TYPE user_role AS ENUM ('admin', 'officer', 'visitor');
CREATE TYPE appointment_status AS ENUM ('pending', 'approved', 'rejected', 'cancelled', 'completed');
CREATE TYPE gender_type AS ENUM ('male', 'female', 'other');

-- Users Table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  phone_number VARCHAR(20),
  role user_role DEFAULT 'visitor',
  is_active BOOLEAN DEFAULT true,
  email_verified BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMP
);

-- Officers Table
CREATE TABLE officers (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(100),
  department VARCHAR(100),
  office_number VARCHAR(50),
  specialization VARCHAR(255),
  bio TEXT,
  profile_image_url VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Visitors Table
CREATE TABLE visitors (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  id_number VARCHAR(50) UNIQUE,
  id_type VARCHAR(50),
  gender gender_type,
  date_of_birth DATE,
  institution VARCHAR(255),
  institution_position VARCHAR(100),
  address TEXT,
  city VARCHAR(100),
  county VARCHAR(100),
  postal_code VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Availability Table
CREATE TABLE availability (
  id SERIAL PRIMARY KEY,
  officer_id INTEGER NOT NULL REFERENCES officers(id) ON DELETE CASCADE,
  day_of_week INTEGER NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  break_start TIME,
  break_end TIME,
  max_appointments_per_day INTEGER DEFAULT 10,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Appointments Table
CREATE TABLE appointments (
  id SERIAL PRIMARY KEY,
  visitor_id INTEGER NOT NULL REFERENCES visitors(id) ON DELETE CASCADE,
  officer_id INTEGER NOT NULL REFERENCES officers(id) ON DELETE CASCADE,
  appointment_date DATE NOT NULL,
  appointment_time TIME NOT NULL,
  status appointment_status DEFAULT 'pending',
  purpose_of_meeting TEXT,
  notes TEXT,
  reminder_sent BOOLEAN DEFAULT false,
  reschedule_reason TEXT,
  reschedule_count INTEGER DEFAULT 0,
  cancellation_reason TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(officer_id, appointment_date, appointment_time)
);

-- Visitor Logs Table
CREATE TABLE visitor_logs (
  id SERIAL PRIMARY KEY,
  visitor_id INTEGER NOT NULL REFERENCES visitors(id) ON DELETE CASCADE,
  appointment_id INTEGER REFERENCES appointments(id) ON DELETE SET NULL,
  check_in_time TIMESTAMP,
  check_out_time TIMESTAMP,
  officer_met VARCHAR(255),
  duration_minutes INTEGER,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reports Table
CREATE TABLE reports (
  id SERIAL PRIMARY KEY,
  report_type VARCHAR(100) NOT NULL,
  generated_by INTEGER NOT NULL REFERENCES users(id),
  report_data JSONB,
  filters JSONB,
  file_path VARCHAR(500),
  generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  expiry_date TIMESTAMP
);

-- Notifications Table
CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type VARCHAR(100),
  title VARCHAR(255),
  message TEXT,
  related_appointment_id INTEGER REFERENCES appointments(id),
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_officers_user_id ON officers(user_id);
CREATE INDEX idx_visitors_user_id ON visitors(user_id);
CREATE INDEX idx_availability_officer_id ON availability(officer_id);
CREATE INDEX idx_appointments_visitor_id ON appointments(visitor_id);
CREATE INDEX idx_appointments_officer_id ON appointments(officer_id);
CREATE INDEX idx_appointments_date ON appointments(appointment_date);
CREATE INDEX idx_appointments_status ON appointments(status);
CREATE INDEX idx_visitor_logs_visitor_id ON visitor_logs(visitor_id);
CREATE INDEX idx_visitor_logs_appointment_id ON visitor_logs(appointment_id);
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_read ON notifications(is_read);
