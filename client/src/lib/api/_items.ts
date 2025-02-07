import { Item } from "../types"
import axios from 'axios'
import { filterOut } from "../utils/type_utils"

export const syncListings = async (item: Item) => {
  const response = await axios.post(`/items/${item.id}/sync_listings`)
  console.log('Synced listings for item:', response.data)
  return response.data
}

export const getAll = async () => {
  const response = await axios.get('/items')
  return response.data
}

export const get = async(id: number) => {
  const response = await axios.get(`/items/${id}`)
  return response.data
}

export const create = async(item: Partial<Item>): Promise<Item> => {
  const response = await axios.post('/items', item)
  return response.data
}

export const update = async (item: Item): Promise<Item> => {
  const filteredItemData = filterOut(item, 'id', 'created_at', 'updated_at')

  const response = await axios.put(`/items/${item.id}`, filteredItemData)
  return response.data
}

export const destroy = async(id: number) => {
  const response = await axios.delete(`/items/${id}`)
  return response.data
}
