# **Student Portal Site**

This is a web application built using Ruby on Rails to manage assignments and submissions. The platform allows teachers (admins) to create assignments and view student submissions. Students can upload files to assignments created by their teachers.

---

## **Features**

### Admin (Teacher) Features
- Create, edit, and delete assignments.
<img src="https://github.com/SapporoAlex/Student-Portal-Site/blob/master/create.jpg" width="500px" height="auto">
- View all student submissions for each assignment.
<img src="https://github.com/SapporoAlex/Student-Portal-Site/blob/master/admin.jpg" width="500px" height="auto">

### Student Features

- View available assignments.
<img src="https://github.com/SapporoAlex/Student-Portal-Site/blob/master/list.jpg" width="500px" height="auto">

- Upload files to specific assignments.
<img src="https://github.com/SapporoAlex/Student-Portal-Site/blob/master/uploaded.jpg" width="500px" height="auto">

### Authentication
- User authentication is handled using [Devise](https://github.com/heartcombo/devise).
- Admins and students have different permissions.
<img src="https://github.com/SapporoAlex/Student-Portal-Site/blob/master/login.jpg" width="500px" height="auto">

---

## **Installation**

1. Clone the Repository:
   ```bash
   git clone https://github.com/your-username/assignment-platform.git
   cd assignment-platform
   ```
   
2. Install Dependencies:

```bash
bundle install
```

3. Set Up the Database:

```bash
rails db:create
rails db:migrate
```

4. Start the Server:

```bash
rails server
```
5. Visit the app at http://localhost:3000.

## Usage
1. Sign Up/Login:
- Students and admins can sign up or log in via the homepage.

2. Admin Dashboard:
- Create new assignments and manage existing ones.

3. Student Dashboard:
-View assignments and upload files.

## File Structure
app/controllers: Controllers for assignments and submissions.
app/models: Models for Assignment, Submission, and User.
app/views: Views for assignments, submissions, and Devise.

## Contributing
Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Submit a pull request with detailed information about your changes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
