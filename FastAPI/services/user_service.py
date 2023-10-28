from ..models.DBModel import User
from ..config.Config import db

class UserService:
    @staticmethod
    def create_user(data):
        new_user = User(
            id=data['id'], 
            password=data['password'],
        )
        db.session.add(new_user)
        db.session.commit()
        return new_user

    @staticmethod
    def get_user_by_id(id):
        return User.query.filter_by(id=id).first()
    
    @staticmethod
    def update_password(email, password, new_password):
        user = User.query.filter_by(email = email).first()

        if user:
            if user.password == password:
                user.password = new_password
                db.session.commit()
                return True
            else:
                return False
        else:
            return False
