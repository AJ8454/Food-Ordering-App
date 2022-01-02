import 'mocha'
import chai, { expect } from 'chai'
import SignInUseCase from '../../../src/auth/usecases/signinUsecase'
import IAuthRepository from '../../../src/auth/domain/IAuthRepository'
import IPasswordService from '../../../src/auth/services/IPasswordService'

describe('SignInUseCase', () => {
    let sut: SignInUseCase
    let repository: IAuthRepository
    let passwordService: IPasswordService

    const user = {
        email: 'ajay@gmai.com',
        id: '001',
        name: 'AJ',
        password: 'Aj123AY',
        type: 'email',
    }

    beforeEach(
        () => {
            repository = new FakeRepository()
            passwordService = new FakePasswordService()
            sut = new SignInUseCase(repository, passwordService)

        }
    )
}
)