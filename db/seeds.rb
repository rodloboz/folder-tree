[
  Item,
  SupermarketProduct,
  Folder,
  Supermarket,
  List,
  Product
].each(&:destroy_all)

def process_node(node, parent = nil)
  attrs = { name: node[:name] }
  attrs.merge!(folder_id: parent.id) if parent

  parent = Folder.create(attrs)
  children = node[:folders] || []

  children.each { |child| process_node(child, parent) }
end


FOLDERS = {
  name: 'root',
  folders: [
    {
      name: 'legal',
      folders: [
        {
          name: 'contracts',
        },
        {
          name: 'due diligence'
        }
      ]
    },
    {
      name: 'marketing',
      folders: [
        {
          name: 'research'
        }
      ]
    },
    {
      name: 'assorted'
    }
  ]
}

process_node(FOLDERS)

500.times do
  Product.create!(
    name: Faker::Food.ingredient,
    price_cents: Faker::Commerce.price(range: 100..2000, as_string: false)
  )
rescue ActiveRecord::RecordInvalid
  next
end

5.times do
  Supermarket.create!(name: Faker::Company.name)
rescue ActiveRecord::RecordInvalid
  next
end

3.times do
  List.create!(name: Faker::Marketing.buzzwords)
rescue ActiveRecord::RecordInvalid
  next
end

List.find_each do |list|
  rand(5..15).times do
    list.products << Product.all.sample
  rescue ActiveRecord::RecordInvalid
    next
  end
end

Supermarket.find_each do |supermarket|
  rand(50..355).times do
    supermarket.products << Product.all.sample
  rescue ActiveRecord::RecordInvalid
    next
  end
end



