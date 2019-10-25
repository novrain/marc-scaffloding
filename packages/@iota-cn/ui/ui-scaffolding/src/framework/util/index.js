export const createi18n = (prefix) => {
    return (key) => {
        return `${prefix}${key}`
    }
}