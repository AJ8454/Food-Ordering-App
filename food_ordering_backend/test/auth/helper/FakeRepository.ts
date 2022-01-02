import IAuthRepository from "../../../src/auth/domain/IAuthRepository";
import User from "../../../src/auth/domain/user";

export default class FakeRepository implements IAuthRepository {

    public users = [
        {
            email: 'ajay123@gmail.com',
            id: '101',
            name: 'Ken',
            password: 'sd5f515sd',
            type: 'email',
        },
        {
            email: 'rahul123@gmail.com',
            id: '102',
            name: 'Rahul',
            password: '',
            type: 'google',
        }
    ]

    public async find(email: string): Promise<User> {
        const user = this.users.find((x) => x.email == email)

        if (!user) return Promise.reject('User not found')
        return new User(
            user?.id,
            user?.name,
            user?.email,
            user?.password,
            user?.type
        )
    }
    
    public async add(name: string, email: string, passwordHash: string, type: string): Promise<string> {
        const max = 9999
        const min = 1000
        const id = (
            Math.floor(Math.random() * (+max - +min)) + +min).toString()

        this.users.push({
            email: email,
            id: id,
            name: name,
            password: passwordHash,
            type: type,
        })
        return id
    }
}