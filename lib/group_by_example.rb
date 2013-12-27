k = Struct.new(:name, :color)

a = []
a << k.new("bob", "blue")
a << k.new("bob", "green")
a << k.new("bob", "yellow")
a << k.new("bob", "red")
a << k.new("ted", "blue")
a << k.new("ted", "green")
a << k.new("ted", "yellow")
a << k.new("ted", "red")
a << k.new("carol", "blue")
a << k.new("carol", "green")
a << k.new("carol", "yellow")
a << k.new("carol", "red")
a << k.new("alice", "blue")
a << k.new("alice", "green")
a << k.new("alice", "yellow")
a << k.new("alice", "red")
groups = a.group_by(&:color)
puts groups.keys
puts groups["red"]