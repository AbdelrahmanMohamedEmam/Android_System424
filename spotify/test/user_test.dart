import 'package:flutter_test/flutter_test.dart';
import 'package:spotify/API_Providers/userAPI.dart' as user;



void main() async{


group('UserAPI Tests',(){

  test('Upgrade Premium', () async{
    final userAPI= new user.UserAPI(baseUrl: 'http://spotify.mocklab.io');
    final item= await userAPI.upgradePremium('12345','12345');
    expect(item,true);

  });
  test('Upgrade Premium', () async{
    final userAPI= new user.UserAPI(baseUrl: 'http://spotifybad.mocklab.io');
    expect(userAPI.upgradePremium('12345','12345'),throwsA(isInstanceOf<Exception>()));
  });


  test('Forgetting password', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotify.mocklab.io');
    final response=await userAPI.forgetPassword('email');
    expect(response, true);
  }
  );
  test('Forgetting password Bad', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotifybad.mocklab.io');
    final response=await userAPI.forgetPassword('email');
    expect(response, false);
  }
  );


  test('Change password', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotify.mocklab.io');
    final response=await userAPI.changePasswordApi('token', 'newPassword', 'oldPassword');
    expect(response, true);
  }
  );
  test('Change password Bad', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotifybad.mocklab.io');
    final response=await userAPI.changePasswordApi('token', 'newPassword', 'oldPassword');
    expect(response, false);
  }
  );


  test('Setting User', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotify.mocklab.io');
    final response= await userAPI.setUser('1234');
    expect(response.name, 'Ziad Shebl');
    expect(response.email, 'ziadshebl@gmail.com');
    expect(response.dateOfBirth, "1999-2-21");
    expect(response.gender, 'male');
  }
  );
  test('Setting User Bad', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotifybad.mocklab.io');
    expect(userAPI.setUser('1234'), throwsA(isInstanceOf<Exception>()));
  }
  );


  test('Follow artist', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotify.mocklab.io');
    final response=await userAPI.followArtist('token', '1');
    expect(response, true);
  }
  );
  test('Follow artist bad', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotifybad.mocklab.io');
    final response=await userAPI.followArtist('token', '1');
    expect(response, false);
  }
  );

  test('sign in', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotify.mocklab.io');
    final response=await userAPI.signIn('email','password');
    expect(response['success'], true);
  }
  );
  test('sign in failed', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotifybad.mocklab.io');
    expect(userAPI.signIn('email','password'), throwsA(isInstanceOf<Exception>()));
  }
  );

  test('sign up', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotify.mocklab.io');
    final response=await userAPI.signUp('email','password','gender','username','dateOfBirth');
    expect(response['success'], true);
  }
  );
  test('sign up failed', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotifybad.mocklab.io');
    expect(userAPI.signUp('email','password','gender','username','dateOfBirth'), throwsA(isInstanceOf<Exception>()));
  }
  );


  test('ask for premium', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotify.mocklab.io');
    final response=await userAPI.askForPremium('token');
    expect(response, true);
  }
  );
  test('ask for premium failed', () async {
    final userAPI= new user.UserAPI(baseUrl: 'http://spotifybad.mocklab.io');
    expect(userAPI.askForPremium('token'), throwsA(isInstanceOf<Exception>()));
  }
  );
});
}
