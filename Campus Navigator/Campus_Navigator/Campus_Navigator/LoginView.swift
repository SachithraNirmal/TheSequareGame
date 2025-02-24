import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Welcome !")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40)

            // Email Input
            VStack(alignment: .leading, spacing: 5) {
                Text("Email")
                    .font(.caption)
                TextField("Enter your email", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            }
            .padding(.horizontal)

            // Password Input
            VStack(alignment: .leading, spacing: 5) {
                Text("Password")
                    .font(.caption)
                HStack {
                    SecureField("********", text: $password)
                    Image(systemName: "eye.slash") // Eye icon for visibility toggle
                        .foregroundColor(.gray)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            }
            .padding(.horizontal)

            // Forgot Password Button
            HStack {
                Spacer()
                Button(action: {}) {
                    Text("Forgot Password?")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)

            // Login Button
            Button(action: {}) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            // OR Divider
            HStack {
                Rectangle().frame(height: 1).foregroundColor(.gray)
                Text("Or")
                    .font(.caption)
                    .foregroundColor(.gray)
                Rectangle().frame(height: 1).foregroundColor(.gray)
            }
            .padding(.horizontal)

            // Social Login Buttons
            VStack(spacing: 10) {
                SocialLoginButton(icon: "applelogo", text: "Continue with Apple")
                SocialLoginButton(icon: "globe", text: "Continue with Google")
                SocialLoginButton(icon: "facebook", text: "Continue with Facebook")
            }

            // Sign Up Prompt
            HStack {
                Text("Don’t have an account?")
                    .foregroundColor(.gray)
                Button(action: {}) {
                    Text("Sign up")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 10)

            Spacer()
        }
        .padding()
    }
}

// Custom Button for Social Login
struct SocialLoginButton: View {
    let icon: String
    let text: String

    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                Text(text)
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }
        .padding(.horizontal)
    }
}

// Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
