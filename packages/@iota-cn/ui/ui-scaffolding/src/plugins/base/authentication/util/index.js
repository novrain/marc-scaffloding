export const createEmptyUser = () => {
    return {
        username: '--',
        mobile: '--',
        email: '--',
        gravatar: undefined,
        actEmail: 0,
    }
}

//扩展信息
let educationOptions = undefined

export const setEducationOptions = (options) => {
    educationOptions = options
}

let politicsOptions = undefined

export const setPoliticsOptions = (options) => {
    politicsOptions = options
}

export {
    educationOptions,
    politicsOptions
}