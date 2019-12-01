export const createEmptyUser = () => {
    return {
        username: '--',
        mobile: '--',
        email: '--',
        gravatar: undefined,
        actEmail: 0,
    }
}

let educationOptions = undefined

export const setEducationOptions = (options) => {
    educationOptions = options
}

export {
    educationOptions
}