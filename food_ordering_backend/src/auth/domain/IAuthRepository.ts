import User from "./user";

export default interface IAuthRepository {
    find(email: string): Promise<User>
    add(name: string, email: string, passwordHash: string, type: string,):
        Promise<string>
}