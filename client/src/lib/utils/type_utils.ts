import { Item } from "../types"

export const filterOut = <T extends object>(obj: T, ...keys: (keyof T)[]) => {
  const filtered = { ...obj }
  keys.forEach(key => delete filtered[key])
  return filtered
}

export const buildItem = (): Partial<Item> => {
  return {
    wear: 'factory_new',
    category: 'weapon',
    stattrak: false,
    souvenir: false,
  } as Partial<Item>
}